//
//  MovieSearchViewModel.swift
//  MEGABOX
//
//  Created by 정승윤 on 10/8/25.
//

import Foundation
import SwiftUI
import Combine

// @Observable 쓰면 Published를 못씀
class MovieSearchViewModel: ObservableObject {
    var movies: [MovieModel] = [
        MovieModel(posterName: "noway", secPosterName: "f1Poster",name: "어쩔수가없다",engname:"No Other Choice" ,performance: "20만", age: "15"),
        MovieModel(posterName: "blade",secPosterName: "f1Poster", name: "귀멸의칼날",engname:"Demon Slayer: Kimetsu no Yaiba – The Movie: Infinity Castle" ,performance: "1", age: "15"),
        MovieModel(posterName: "f1",secPosterName: "f1Poster", name: "F1 더 무비",engname:"F1 The Movie" ,performance: "50", age: "12"),
        MovieModel(posterName: "face", secPosterName: "f1Poster",name: "얼굴",engname:"The Ugly" ,performance: "2", age:"15"),
        MovieModel(posterName: "hime",secPosterName: "f1Poster", name: "모노노케 히메 ",engname:"Princess Mononoke", performance:"3", age:"ALL"),
        MovieModel(posterName: "yadang",secPosterName: "f1Poster", name: "야당 ",engname:"YADANG: The Snitch", performance:"3", age:"19"),
        MovieModel(posterName: "roses",secPosterName: "f1Poster", name: "더 로즈: 완벽한 이혼 ",engname:"The Roses", performance:"3", age:"15"),
        MovieModel(posterName: "boss",secPosterName: "f1Poster", name: "보스 ",engname:"Boss", performance:"3", age:"15")
    ]
    
    @Published var query: String = ""
    @Published var results: [MovieModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
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
                let filtered = self.movies.filter { $0.name.lowercased().contains(query) }
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
