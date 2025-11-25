//
//  MovieViewModel.swift
//  MEGABOX
//
//  Created by 박정환 on 10/1/25.
//

import Foundation
import Moya

@Observable
class MovieViewModel {
    var movies: [MovieModel] = []
    
    let service = TMDBService()
    
    @MainActor
    func fetchNowPlaying() async {
        do {
            // 서비스로부터 현재 상영 중인 영화 요청
            let response = try await service.request(.nowPlaying(page: 1))
            // JSON 응답을 DTO로 디코딩
            let dto = try JSONDecoder().decode(NowPlayingResponseDTO.self, from: response.data)
            // DTO 결과를 MovieModel로 매핑하여 movies에 할당
            self.movies = dto.results.map { movie in
                MovieModel(
                    title: movie.title,
                    poster: "https://image.tmdb.org/t/p/w500" + (movie.posterPath ?? ""),
                    countAudience: "100만"
                )
            }
        } catch {
            // 에러 메시지 출력
            print("현재 상영 중인 영화 불러오기 실패: \(error)")
            // 실패 시 더미 데이터로 대체
            self.movies = [
                .init(title: "어쩔 수가 없다", poster: "poster1", countAudience: "20만"),
                .init(title: "극장판 귀멸의 칼날", poster: "poster2", countAudience: "1"),
                .init(title: "F1 더 무비", poster: "poster3", countAudience: "30만")
            ]
        }
    }
}
