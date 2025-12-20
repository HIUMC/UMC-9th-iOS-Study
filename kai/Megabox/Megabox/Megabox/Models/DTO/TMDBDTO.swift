//
//  TMDBDTO.swift
//  Megabox
//
//  Created by 김지우 on 11/13/25.
//

import Foundation


// MARK: - NowPlayingResponse (전체 응답)
struct NowPlayingResponse: Decodable {
    let dates: Dates
    let page: Int
    let results: [MovieResult] // 우리가 필요한 영화 목록
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates (날짜 정보)
struct Dates: Decodable {
    let maximum, minimum: String
}

// MARK: - MovieResult (개별 영화 정보)
struct MovieResult: Decodable, Hashable {
        let id: Int
        let originalTitle: String?
        let overview: String?
        let releaseDate: String?
        let popularity: Double?
        let backdropPath: String?
        let posterPath: String?
        let title: String?
        let voteAverage: Double?
        let voteCount: Int?
        let genreIds: [Int]?
        let originalLanguage: String?
        let adult: Bool?
        let video: Bool?

    
    
    enum CodingKeys: String, CodingKey {
        case id, overview, title, popularity, adult, video
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case genreIds = "genre_ids"
        case originalLanguage = "original_language"
    }
    
    // 포스터 이미지의 전체 URL을 반환하는 편의 프로퍼티
    var fullPosterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        // TMDB에서 이미지를 가져올 때는 "https://image.tmdb.org/t/p/w500" 형식을 사용
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
}



// MARK: - MovieDetailDTO (상세 정보 응답)
struct MovieDetailDTO: Decodable, Hashable {
    let backdropPath: String?       // 배경 포스터
    let originalTitle: String       // 원제
    let overview: String?           // 줄거리
    let releaseDate: String         // 개봉일
    let title: String               // 한국어 제목

    // Kingfisher가 사용할 전체 URL
    var fullBackdropURL: URL? {
        guard let path = backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case originalTitle = "original_title"
        case overview
        case releaseDate = "release_date"
        case title
    }
}
