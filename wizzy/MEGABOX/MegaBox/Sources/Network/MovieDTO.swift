//
//  MovieDTO.swift
//  MegaBox
//
//  Created by 이서현 on 11/8/25.
//

import Foundation

// 1) 전체 응답
struct NowPlayingResponse: Codable {
    let dates: NowPlayingDates?
    let page: Int
    let results: [MovieDTO]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// 2) dates 객체
struct NowPlayingDates: Codable {
    let maximum: String //fix ; Date로?
    let minimum: String
}

// 3) 영화 하나
struct MovieDTO: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIDs: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDs = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}


//MARK: - 영화 모델

extension MovieDTO {
    func toModel() -> MovieModel {
        return MovieModel(
            title: title,
            poster: posterPath ?? "",
            countAudience: nil // TMDB 응답엔 없음
        )
    }
}


//MARK: - 영화 상세 모델

extension MovieDTO {
    func toDetailModel() -> MovieDetailModel {
        return MovieDetailModel(
            id: id,
            title: title,
            originalTitle: originalTitle,
            overview: overview,
            posterPath: posterPath,
            backdropPath: backdropPath,
            releaseDate: releaseDate
        )
    }
}
