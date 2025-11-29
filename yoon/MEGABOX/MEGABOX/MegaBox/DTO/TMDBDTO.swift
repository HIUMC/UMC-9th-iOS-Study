//
//  MovieDTO.swift
//  MEGABOX
//
//  Created by 정승윤 on 11/12/25.
//

import Foundation

struct RequestDTO {
    let language: String
    let page: Int
    let region: String
}

struct ResponseDTO: Decodable {
    let dates: DateRangeDTO?
    let page: Int
    let results: [MovieDetailDTO] // 실제 영화 목록 데이터
    let totalPages: Int
    let totalResults: Int

    private enum CodingKeys: String, CodingKey {
        case page
        case results
        case dates
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    }
struct DateRangeDTO: Codable {
        let maximum: String? // 최대 날짜
        let minimum: String? // 최소 날짜
}

struct MovieDetailDTO: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIds: [Int]?
    let id: Int
    let originalLanguage: String?
    let originalTitle: String
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
    private enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
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
        case genreIds = "genre_ids"
    }
}

extension MovieDetailDTO {
    
    // 이미지 기본 URL
    private static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    
    // 1. MovieCardModel로 변환하는 매핑 함수
    func toMovieCardModel(hardcodedAttendance: String, hardcodedRating: String) -> MovieCardModel {
        
        let posterFullPath = MovieDetailDTO.imageBaseURL + (self.posterPath ?? "")
        
        let backdropFullPath = MovieDetailDTO.imageBaseURL + (self.backdropPath ?? "")
        
        return MovieCardModel(
            id: self.id,
            title: self.title,
            posterURL: posterFullPath,
            originalTitle: self.originalTitle, // DTO에서 바로 사용
            backdropURL: backdropFullPath,
            overview: self.overview ?? "줄거리 정보 없음", // DTO에서 바로 사용
            releaseDate: self.releaseDate ?? "미정", // DTO에서 바로 사용
            rating: hardcodedRating,
            attendance: hardcodedAttendance
        )
    }
}

