//
//  MovieEndpoints.swift
//  MEGABOX
//
//  Created by 고석현 on 11/12/25.
//



import Foundation
import Moya

// MARK: - 영화 관련 API 엔드포인트 정의
enum MovieEndpoints {
    case nowPlaying
   
}

// MARK: - TargetType 채택
extension MovieEndpoints: TargetType {
    
    // 기본 URL
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    // 요청 경로
    var path: String {
        switch self {
        case .nowPlaying:
            return "/movie/now_playing"
        }
    }
    
    // HTTP 메서드 -> GET
    var method: Moya.Method {
        return .get
    }
    
    // 파라미터 설정 (쿼리)~ / query에 API KEY 같이 보냄
    var task: Task {
        switch self {
        case .nowPlaying:
            let params: [String: Any] = [
                "api_key": Secret.tmdbAPIKey,
                "language": "ko-KR",
                "region": "KR",
                "page": 1
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    // 요청 헤더
//    var headers: [String : String]? {
//        // xcconfig 또는 Info.plist에서 Bearer Token 읽기
//        guard let token = Bundle.main.object(forInfoDictionaryKey: "TMDB_READ_TOKEN") as? String else {
//            return [
//                "accept": "application/json"
//            ]
//        }
//        return [
//            "accept": "application/json",
//            "Authorization": "Bearer \(token)"
//        ]
//    }
    var headers: [String: String]? {
        return [
            "accept": "application/json",
            "Authorization": "Bearer \(Secret.tmdbReadAccessToken)"
           
        ]
    }
    
    // 샘플 데이터 (테스트용)
    var sampleData: Data {
        switch self {
        case .nowPlaying:
            return """
            {
              "page": 1,
              "results": []
            }
            """.data(using: .utf8)!
        }
    }
}
