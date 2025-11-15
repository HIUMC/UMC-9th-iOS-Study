//
//  MovieEndpoints.swift
//  MEGABOX
//
//  Created by 고석현 on 11/12/25.
//



import Foundation
import Moya

// MARK: - 엔드포인트 정의!
enum MovieEndpoints {
    case nowPlaying
   
}

// MARK: - TargetType !!
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
    
    // 파라미터 설정 (쿼리)~ / query에 API KEY 같이 보냄!
    // 쿼리 파라미터에서 &는 순서 상관 없대 !
    // 쿼리 파라미터는 path var 아님 !!
    //https://api.themoviedb.org/3/movie/now_playing?language=ko-KR&page=1&region=KR 에서  ? 뒤에가 모두 쿼리 파라미터임.
    
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
