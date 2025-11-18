//
//  ViewMOdel.swift
//  week4_practice
//
//  Created by 고석현 on 10/9/25.
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
            .debounce(for: .milliseconds(350), scheduler: DispatchQueue.main)
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
                let filtered = self.model.filter { $0.title.lowercased().contains(query) }
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
    
