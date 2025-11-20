//
//  PlayingDTO.swift
//  MegaBox
//
//  Created by 박병선 on 11/13/25.
//  7주차
import Foundation

struct NowPlayingRequestDTO : Encodable {
    let apikey: String
    let language: String?
    let page: Int?
    let region: String?
}

extension NowPlayingRequestDTO {
    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [
            "api_key": apikey
        ]

        if let language = language {
            dict["language"] = language
        }

        if let page = page {
            dict["page"] = page
        }

        if let region = region {
            dict["region"] = region
        }

        return dict
    }
}

// 전체 응답을 처리
struct MovieResponseDTO: Codable {
    let dates: DatesDTO?
    let page: Int
    let results: [PlayingMovieDTO]
    let totalPages: Int?
    let totalResults: Int?

    // TMDB는 snake_case가 많아서 convertFromSnakeCase로 처리하면 깔끔함
}

struct DatesDTO: Codable {
    let maximum: String?
    let minimum: String?
}

struct PlayingMovieDTO: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]?
    let id: Int
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
}
extension PlayingMovieDTO {
    /// TMDB DTO -> 홈 화면에서 쓰는 Movie 도메인 모델로 변환
    func toMovie() -> Movie {
        let baseImageURL = "https://image.tmdb.org/t/p/w500"
        
        let posterURLString: String
        if let path = posterPath {
            posterURLString = baseImageURL + path
        } else {
            posterURLString = ""   // or "placeholder" 같은 이미지 이름
        }
        
        return Movie(
            title: title ?? "제목 없음",
            poster: posterURLString,
            // TMDB에 없는 값이라 과제 요구대로 하드코딩
            audience: "1,234,567명"
        )
    }
    
    func toMovieDetail() -> MovieDetail {
        let baseImageURL = "https://image.tmdb.org/t/p/w500" //TMDB에서 제공하는 공식 이미지의 BaseURL
            
            // 1) 먼저 Movie(기본 도메인) 하나 만들어주고
            let movie = Movie(
                title: title ?? "제목 없음",
                poster: {
                    if let path = posterPath {
                        return baseImageURL + path
                    } else {
                        return ""
                    }
                }(),
                audience: "1,234,567명"   // 마찬가지로 하드코딩
            )
            
            // 2) 나머지는 DTO 값 + 하드코딩으로 채워서 MovieDetail 생성
            let titleEN = originalTitle ?? (title ?? "제목 없음")
            let description = overview ?? "줄거리 정보가 없습니다."
            let rating = "12세 이상 관람가"                 // 하드코딩
            let release = releaseDate ?? "개봉일 정보 없음"
            let posterDetail = movie.poster                 // 지금은 같은 포스터 사용
            
            return MovieDetail(
                from: movie,
                titleEN: titleEN,
                posterDetail: posterDetail,
                description: description,
                rating: rating,
                releaseDate: release
            )
        }
}
