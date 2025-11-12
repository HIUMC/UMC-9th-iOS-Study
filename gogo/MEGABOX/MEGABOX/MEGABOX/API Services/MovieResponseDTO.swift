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
            let baseURL = "https://image.tmdb.org/t/p/w342"
            let posterURL: String
            if let path = dto.posterPath {
                posterURL = "https://image.tmdb.org/t/p/w342\(path)"
            } else {
                posterURL = ""
            }
            return MovieModel(
                title: dto.title ?? "제목 없음",
                poster: posterURL,
                countAudience: "고정임요!",
                description: dto.overview ?? "줄거리 정보가 없습니다.",
                releaseDate: dto.releaseDate ?? "미정",
                rating: "(*fixed*)세 관람가"
            )
        }
    }
}
