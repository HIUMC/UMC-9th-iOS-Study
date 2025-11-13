//
//  MovieCardDTO.swift
//  UMC_Megabox
//
//  Created by 이한결 on 11/10/25.
//

import Foundation

struct NowPlayingResponseDTO: Codable {
    var results: [MovieCardDTO]
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}
extension NowPlayingResponseDTO {
    func toDomain() -> NowPlayingResponseDomainModel {
        return NowPlayingResponseDomainModel(results: results.map {$0.toDomain()} )
    }
}

struct MovieCardDTO: Identifiable, Hashable, Codable {
    var id: Int
    var moviePoster: String // 영화 포스터
    var movieName: String // 영화 이름
    // var people: String // 누적 관객수 하드코딩
    
    /* 포스터 클릭 시 상세화면 */
    var bigPoster: String
    var subTitle: String
    var explaination: String
    // var smallPoster: String // 작은 포스터 하드코딩
    // var age: String // 관람 등급 하드코딩
    var date: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case moviePoster = "poster_path"
        case movieName = "title"
        case bigPoster = "backdrop_path"
        case subTitle = "original_title"
        case explaination = "overview"
        case date = "release_date"
    }
}
extension MovieCardDTO {
    // TMDB에서 제공하는 imageBaseURL
    // 이 baseURL 뒤에 fetch로 받아온 이미지 데이터를 붙여서 사용함
    private var imageBaseURL: String {
        return "https://image.tmdb.org/t/p/w500"
    }
    
    func toDomain() -> MovieCardDomainModel {
        // baseURL을 이용해서 포스터 URL 생성해줌
        let fullMoviePosterURL = URL(string: imageBaseURL + moviePoster)
        let fullBigPosterURL = URL(string: imageBaseURL + bigPoster)
        
        return MovieCardDomainModel(
            id: id,
            moviePoster: (fullMoviePosterURL)!, // 만들어준 포스터 URL을 파싱
            movieName: movieName,
            people: "1000만", // 하드코딩
            bigPoster: (fullBigPosterURL)!, // 만들어준 포스터 URL을 파싱
            subTitle: subTitle,
            explaination: explaination,
            smallPoster: "poster_f1_small", // 하드코딩
            age: "12세 이상 관람가", // 하드코딩
            date: date)
    }
}
