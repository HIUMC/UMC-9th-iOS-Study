//
//  NowPlayingResponseDTO.swift
//  MEGABOX
//
//  Created by 박정환 on 11/12/25.
//

// MARK: - TMDB Now Playing
struct NowPlayingResponseDTO: Codable {
    let dates: DatesDTO
    let page: Int
    let results: [NowPlayingMovieDTO]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct DatesDTO: Codable {
    let maximum: String
    let minimum: String
}

struct NowPlayingMovieDTO: Codable {
    let id: Int
    let title: String
    let originalTitle: String
    let overview: String
    let releaseDate: String
    let posterPath: String?
    let backdropPath: String?
    let genreIds: [Int]
    let voteAverage: Double
    let voteCount: Int
    let popularity: Double
    let adult: Bool
    let video: Bool
    let originalLanguage: String

    enum CodingKeys: String, CodingKey {
        case id, title, overview, adult, video, popularity
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case originalLanguage = "original_language"
    }
}
