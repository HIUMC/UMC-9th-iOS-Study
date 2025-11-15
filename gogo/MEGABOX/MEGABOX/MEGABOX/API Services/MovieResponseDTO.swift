//
//  MovieResponseDTO.swift
//  MEGABOX
//
//  Created by 고석현 on 11/12/25.
//

import Foundation

// MARK: - 메인 DTO
struct MovieResponseDTO: Decodable {
    let dates: DatesDTO?
    let page: Int
    let results: [MovieResultDTO]
    let totalPages: Int?
    let totalResults: Int?
//Decodable 선언
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
            // TMDB 이미지 Base URL ! Kingfisher에게 URL 로 전달 
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
                backdrop: backdropURL                             //영화 상세 화면 탑 배너 이미지
            )
        }
    }
}
