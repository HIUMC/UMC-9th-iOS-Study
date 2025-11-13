//
//  MovieResponseDTO.swift
//  MEGABOX
//
//  Created by 고석현 on 11/12/25.
//

import Foundation

// MARK: - Now Playing 응답 루트
struct MovieResponseDTO: Decodable {
    let dates: DatesDTO?
    let page: Int
    let results: [MovieResultDTO]
    let totalPages: Int?
    let totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - 날짜 정보
struct DatesDTO: Decodable {
    let maximum: String
    let minimum: String
}

// MARK: - 영화 결과 아이템
struct MovieResultDTO: Decodable {
    let id: Int
    let originalTitle: String?
    let overview: String?
    let releaseDate: String?
    let popularity: Double?
    let backdropPath: String?
    let posterPath: String?

    // 추가적으로 받아올 수 있는 유용한 값들
    let title: String?
    let voteAverage: Double?
    let voteCount: Int?
    let genreIds: [Int]?
    let originalLanguage: String?
    let adult: Bool?
    let video: Bool?
}


// MARK: - DTO → Domain 매핑
extension MovieResponseDTO {
    func toDomain() -> [MovieModel] {
        return results.map { dto in
            // TMDB 이미지 베이스 URL
            let posterBaseURL = "https://image.tmdb.org/t/p/w342"
            let backdropBaseURL = "https://image.tmdb.org/t/p/w780"

            let posterURL = dto.posterPath.map { posterBaseURL + $0 } ?? ""
            let backdropURL = dto.backdropPath.map { backdropBaseURL + $0 }

            return MovieModel(
                title: dto.title ?? dto.originalTitle ?? "제목 없음",
                poster: posterURL,
                countAudience: "고정!명",                          // 과제용 하드코딩
                description: dto.overview ?? "줄거리 정보가 없습니다.",
                releaseDate: dto.releaseDate ?? "미정",
                rating: "고정 관람가",                                  // 과제용 하드코딩
                backdrop: backdropURL                                   // ✅ 새로 추가
            )
        }
    }
}
