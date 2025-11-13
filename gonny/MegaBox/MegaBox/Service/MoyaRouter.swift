//
//  MoyaService.swift
//  MegaBox
//
//  Created by 박병선 on 11/13/25.
//
import Moya
import Foundation

enum TMDBRouter {
    case nowPlaying(query: NowPlayingQuery)
    case movieDetail(id: Int, language: String) // /3/movie/{id}
    case tvDetail(id: Int, language: String)    // /3/tv/{id}
}

extension TMDBRouter: TargetType {
    var baseURL: URL {
        switch self {
        default:
            return URL(string: "\(Config.baseUrl)")!
        }
    }

    var path: String {
        switch self {
        case .nowPlaying:
            return "/3/movie/now_playing"
        case let .movieDetail(id, _):
            return "/3/movie/\(id)"
        case let .tvDetail(id, _):
            return "/3/tv/\(id)"
        }
    }

    var method: Moya.Method { .get }
    var sampleData: Data { Data() }

    var task: Task {
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "TMDB_API_KEY") as? String ?? ""

        switch self {
        case let .nowPlaying(query):
            return .requestParameters(
                parameters: query.asParameters(apiKey: apiKey),
                encoding: URLEncoding.queryString
            )

        case let .movieDetail(_, language):
            return .requestParameters(
                parameters: ["api_key": apiKey, "language": language],
                encoding: URLEncoding.queryString
            )

        case let .tvDetail(_, language):
            return .requestParameters(
                parameters: ["api_key": apiKey, "language": language],
                encoding: URLEncoding.queryString
            )
        }
    }

    var headers: [String : String]? { ["Content-Type": "application/json"] }
}
