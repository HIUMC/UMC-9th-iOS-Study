//
//  MovieSearchViewModel.swift
//  MegaBox
//
//  Created by 이서현 on 10/5/25.
//

import SwiftUI
import Combine


final class MovieSearchViewModel: ObservableObject {
    
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
    
    @Published var query: String = "" // 검색 위한 쿼리
    @Published var results: [MovieModel] = [] // 결과 저장
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    @Published var selectedMovie: MovieModel? = nil
    
    private var bag = Set<AnyCancellable>()
 
    init() {
        $query
            .debounce(for: .milliseconds(400), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.errorMessage = nil
            })
            .flatMap { query in
                self.search(query: query)
            }
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
        return Future<[MovieModel], Error> { [weak self] promise in
            let delay = Double(Int.random(in: 300...700)) / 1000.0
            guard let self else { return }
            
            DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
                let filtered = self.movies.filter { $0.title.lowercased().contains(query) }
                promise(.success(filtered))
            }
        }
        .handleEvents(
            receiveSubscription: { _ in
                DispatchQueue.main.async {
                    self.isLoading = true
                }
            },
            receiveCompletion: { _ in
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        )
        .eraseToAnyPublisher()
    }
    
}
