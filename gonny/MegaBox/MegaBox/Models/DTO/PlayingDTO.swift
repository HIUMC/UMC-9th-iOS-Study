//
//  PlayingDTO.swift
//  MegaBox
//
//  Created by 박병선 on 11/13/25.
//
// umc 7주차 과제
import Foundation

// MARK: - Top-level
/// /3/movie/now_playing 에 쓰는 쿼리 DTO
struct NowPlayingQuery: Encodable {
    let page: Int          // 1 이상
    let language: String   // "ko-KR"
    let region: String?    // "KR" (선택)

    init(page: Int = 1, language: String = "ko-KR", region: String? = "KR") {
        self.page = max(1, page)
        self.language = language
        self.region = region
    }

    /// Moya .requestParameters용 딕셔너리
    func asParameters(apiKey: String) -> [String: Any] {
        var params: [String: Any] = [
            "api_key": apiKey,
            "page": page,
            "language": language
        ]
        if let region { params["region"] = region }
        return params
    }
}

// MARK: - Date range (optional)
struct DateRange: Decodable {
    let maximum: String   // "2025-11-20"
    let minimum: String   // "2025-10-10"
}

// MARK: - Movie item
struct PlayingMovieDTO: Decodable {
    let id: Int
    let title: String
    let originalTitle: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let voteAverage: Double
    let voteCount: Int
    let popularity: Double
    let genreIDs: [Int]
    let adult: Bool
    let originalLanguage: String
    let video: Bool

    private enum CodingKeys: String, CodingKey {
        case id, title, overview, adult, popularity, video
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case genreIDs = "genre_ids"
        case originalLanguage = "original_language"
    }
}
