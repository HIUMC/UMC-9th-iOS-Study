//
//  MovieSearchViewModel.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/7/25.
//

import Foundation
import Combine

class MovieSearchViewModel: ObservableObject {
    // 입력
    @Published var query: String = ""
    
    // 출력
    @Published var searchResults: [Movie] = []
    
    private let allMovies: [Movie] = [
        .init(id: "movie01", name: "F1", imageName: "poster_f1", ageRating: 15),
        .init(id: "movie02", name: "무한성", imageName: "poster_muhanseong", ageRating: 15),
        .init(id: "movie03", name: "어쩔수가없다", imageName: "poster_no_choice", ageRating: 15),
        .init(id: "movie04", name: "얼굴", imageName: "poster_face", ageRating: 15),
        .init(id: "movie05", name: "모노노케히메", imageName: "poster_mononoke", ageRating: 15),
        .init(id: "movie06", name: "보스", imageName: "poster_boss", ageRating: 15),
        .init(id: "movie07", name: "야당", imageName: "poster_yadang", ageRating: 15),
        .init(id: "movie08", name: "더로제스", imageName: "poster_the_roses", ageRating: 15)
    ]
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // ViewModel이 생성될 때 검색 파이프라인 설정
        setupSearchPipeline()
        
        // 처음에는 모든 영화를 보여줌
        searchResults = allMovies
    }
    
    private func setupSearchPipeline() {
        $query
            // 400ms 지연
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            // 중복된 검색어는 무시
            .removeDuplicates()
            .sink { [weak self] newQuery in
                guard let self = self else { return }
                
                // 검색어가 비어있으면 모든 영화를 보여줌
                if newQuery.isEmpty {
                    self.searchResults = self.allMovies
                } else {
                    // 검색어가 있다면, 영화 제목에 검색어가 포함된 것만 필터링
                    self.searchResults = self.allMovies.filter { movie in
                        movie.name.localizedCaseInsensitiveContains(newQuery)
                    }
                }
            }
            .store(in: &cancellables)
    }
}
