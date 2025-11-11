//
//  MovieSearchViewModel.swift
//  Week4_Practice
//
//  Created by 박정환 on 10/7/25.
//

import SwiftUI
import Combine

final class MovieSearchViewModel: ObservableObject {
    private let model: [MovieModel] = [
        .init(movieImage: .init(.mickey), title: "미키", rate: 9.1),
        .init(movieImage: .init(.toystory), title: "토이스토리", rate: 8.2),
        .init(movieImage: .init(.brutalis), title: "브루탈리스트", rate: 8.2),
        .init(movieImage: .init(.snowWhite), title: "백설공주", rate: 8.2),
        .init(movieImage: .init(.whiplash), title: "위플래시", rate: 8.2),
        .init(movieImage: .init(.conclave), title: "콘클라베", rate: 8.2),
        .init(movieImage: .init(.theFall), title: "더폴", rate: 8.2)
    ]
    
    @Published var query: String = ""
    @Published var results: [MovieModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private var bag = Set<AnyCancellable>()
    
    init() {
        $query
            .debounce(for: .milliseconds(350), scheduler: DispatchQueue.main) //사용자가 입력을 멈춘 뒤 350ms 이후에만 동작
            .removeDuplicates() //이전 값과 같다면 값을 무시하고 건너뜀
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.errorMessage = nil
            })
            .flatMap { query in //검색어가 변경될 때마다 search(query:)를 통해 영화 조회
                self.search(query: query)
            }
            .receive(on: DispatchQueue.main) //UI 상태 업데이트를 위해 메인 스레드에서 처리
            .sink { [weak self] completion in //Publisher로부터 최종 검색어를 받아 성공시 results에 저장
                if case .failure(let err) = completion {
                    self?.errorMessage = "검색 실패: \(err.localizedDescription)"
                    self?.results = []
                }
            } receiveValue: { [weak self] items in
                self?.results = items
            }
            .store(in: &bag) //AnyCancellable 구독을 유지
    }

    private func search(query: String) -> AnyPublisher<[MovieModel], Error> { //실패해도 앱이 멈추지 않도록 Never 실패 타입을 명시
        return Future<[MovieModel], Error> { [weak self] promise in
            let delay = Double(Int.random(in: 300...700)) / 1000.0
            guard let self else { return }
            
            DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
                let filtered = self.model.filter { $0.title.lowercased().contains(query) }
                promise(.success(filtered))
            }
        }
        .handleEvents( //handleEvents를 통해 메인에서 로딩 처리
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
