

//
//  MovieSearchViewModel.swift
//  Megabox
//
//  Created by 김지우 on 10/9/25.
//

import Foundation
import Combine

//   Movie 모델을 사용
final class MovieSearchViewModel: ObservableObject {

    // Input
    @Published var searchText: String = ""

    // DataSource
    private let allMovies: [Movie] //   [Movie]

    // Output
    @Published private(set) var filteredMovies: [Movie] = [] //   [Movie]

    private var bag = Set<AnyCancellable>()

    //   [BookingMovie] -> [Movie]
    init(allMovies: [Movie]) {
        self.allMovies = allMovies
        self.filteredMovies = allMovies

        // 검색 파이프라인 (로직은 동일)
        $searchText
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .removeDuplicates()
            .map { [allMovies] keyword -> [Movie] in //   [Movie] 반환
                let key = keyword.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !key.isEmpty else { return allMovies }
                //   Movie.title로 필터링
                return allMovies.filter { $0.title.localizedCaseInsensitiveContains(key) }
            }
            .receive(on: RunLoop.main)
            .assign(to: &$filteredMovies)
    }

    func clear() {
        searchText = ""
    }
}
