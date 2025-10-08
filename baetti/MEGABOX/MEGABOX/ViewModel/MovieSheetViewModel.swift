//
//  MovieSheetViewModel.swift
//  MEGABOX
//
//  Created by 박정환 on 10/8/25.
//

import SwiftUI
import Combine

final class MovieSheetViewModel: ObservableObject {

    @Published var movies: [MovieModel] = [
        .init(title: "F1 더 무비", poster: "poster3", countAudience: "30만"),
        .init(title: "귀멸의 칼날", poster: "poster2", countAudience: "1"),
        .init(title: "어쩔 수가 없다", poster: "poster1", countAudience: "20만"),
        .init(title: "얼굴", poster: "poster4", countAudience: nil),
        .init(title: "모노노케 히메", poster: "poster5", countAudience: nil),
        .init(title: "보스", poster: "poster6", countAudience: nil),
        .init(title: "야당", poster: "poster7", countAudience: nil),
        .init(title: "THE ROSES", poster: "poster8", countAudience: nil)
    ]

    @Published var query: String = ""
    @Published var results: [MovieModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var selectedMovie: MovieModel?

    private var bag = Set<AnyCancellable>()

    init() {
        $query
            // 공백 제거
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            // 400ms 디바운스
            .debounce(for: .milliseconds(400), scheduler: DispatchQueue.main)
            // 동일값 무시
            .removeDuplicates()
            // 에러 초기화
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.errorMessage = nil
            })
            // 쿼리 변경마다 검색
            .flatMap { [weak self] q -> AnyPublisher<[MovieModel], Error> in
                guard let self = self else {
                    return Just<[MovieModel]>([])
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                }
                return self.search(query: q)
            }
            // UI 업데이트는 메인
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let err) = completion {
                    self?.errorMessage = "검색 실패: \(err.localizedDescription)"
                    self?.results = []
                }
            } receiveValue: { [weak self] items in
                self?.results = items
            }
            .store(in: &bag)
    }

    private func search(query: String) -> AnyPublisher<[MovieModel], Error> {
        Future<[MovieModel], Error> { [weak self] promise in
            guard let self = self else { return }
            let delay = Double(Int.random(in: 300...700)) / 1000.0
            let q = query.lowercased()

            DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
                let filtered: [MovieModel]
                if q.isEmpty {
                    filtered = self.movies
                } else {
                    filtered = self.movies.filter { $0.title.lowercased().contains(q) }
                }
                promise(.success(filtered))
            }
        }
        .handleEvents(
            receiveSubscription: { [weak self] _ in
                DispatchQueue.main.async { self?.isLoading = true }
            },
            receiveCompletion: { [weak self] _ in
                DispatchQueue.main.async { self?.isLoading = false }
            }
        )
        .eraseToAnyPublisher()
    }

    func select(movie: MovieModel) {
        selectedMovie = movie
    }
}
