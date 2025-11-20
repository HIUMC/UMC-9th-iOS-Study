//
//  MoyaService.swift
//  MegaBox
//
//  Created by 박병선 on 11/13/25.
//
import Foundation
import Moya

// MARK: - 영화 관련 API 엔드포인트 정의
enum TMDBRouter {
    case nowPlaying(NowPlayingRequestDTO)
}

// MARK: - TargetType 채택
extension TMDBRouter: TargetType {
    
    // 기본 URL
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    
    var path: String {
        switch self {
        case .nowPlaying:
            return "/movie/now_playing"
        }
    }
    
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .nowPlaying(let dto):
            return .requestParameters(parameters: dto.toDictionary(), encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        return [
            "Authorization": "Bearer \(Secret.tmdbReadAccessToken)",
            "Accept": "application/json"
            
        ]
    }
}
