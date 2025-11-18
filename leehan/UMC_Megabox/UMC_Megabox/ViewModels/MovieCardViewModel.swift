//
//  MovieCardViewModel2.swift
//  UMC_Megabox
//
//  Created by 이한결 on 11/10/25.
//

import Foundation

@MainActor
final class MovieCardViewModel: ObservableObject {
    // MovieCardDomainModel 배열
    // 뷰에서 이 배열을 감지해서 ForEach로 순회하여 반영
    @Published var movies: [MovieCardDomainModel] = []
    
    // MovieService 인스턴스 생성
    private var movieService = MovieService()
    
    // 뷰에서 호출할 함수
    // MovieService의 fetchMovieData() 함수를 호출하는 역할
    func loadMovies() async {
        Task {
            do {
                /// fetchMovieData()함수로 API 호출을 보냄
                /// 반환된 NowPlayingResponseDomainModel을 domainModel에 저장하고
                /// 저장되어 있는 results를 movies 배열에 저장
                let domainModel = try await movieService.fetchMovieData()
                self.movies = domainModel.results
            } catch {
                print("MovieCardViewModel2: loadMovies() 실패", error.localizedDescription)
            }
        }
    }
}
