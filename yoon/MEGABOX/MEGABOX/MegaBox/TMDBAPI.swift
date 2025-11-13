//
//  TMDBAPI.swift
//  MEGABOX
//
//  Created by 정승윤 on 11/12/25.
//

import Foundation
import Moya

enum TMDBAPI {
    
    case getMovie(request: RequestDTO)
    case getMovieDetail(id: Int)
    case postMovie(name: String) // 여기에 추가
    case putMovie(name: String)
    case patchMovie(name: String)
    case deleteMovie(name: String)
}

//
extension TMDBAPI: TargetType {
    
    // 요청을 보낼 서버의 기본 주소
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    // baseURL 뒤에 붙을 세부 경로
    var path: String {
        switch self {
        case .getMovie:
            return "/movie/now_playing"
        case .getMovieDetail(let id):
            return "/movie/\(id)"
            // 나머지 케이스들은 명시적인 경로가 있어야 합니다.
        case .postMovie, .putMovie, .patchMovie, .deleteMovie:
            return "/movie/generic"
        }
        
    }
    var method: Moya.Method {
                return .get
    }
    
    var task: Task {
            switch self {
            case .getMovie(let request):
                // RequestDTO의 파라미터를 사용합니다.
                return .requestParameters(parameters: [
                    "language": request.language,
                    "page": request.page,
                    "region": request.region
                ], encoding: URLEncoding.default)
                
            case .getMovieDetail:
                // 상세 정보 요청 시 언어 파라미터만 추가합니다.
                return .requestParameters(parameters: [
                    "language": "ko-KR"
                ], encoding: URLEncoding.default)
                
            case .postMovie(let name):
                // POST 요청은 JSON 인코딩을 사용합니다.
                return .requestJSONEncodable(["name": name])
                
            default:
                return .requestPlain
            }
        }
        
        
        var headers: [String: String]? {
            // 💡 TMDB 인증 토큰 (Bearer Token)을 여기에 추가합니다.
            // 예를 들어: ["Authorization": "Bearer YOUR_ACCESS_TOKEN"]
            return ["Content-Type": "application/json",
                            "Authorization": "Bearer \(Config.tmdbAPIKey)"]
        }
    
    // 테스트용으로 돌려줄 가짜 응답 데이터
    var sampleData: Data {
        return "{\"message\": \"Hello, world!\"}".data(using: .utf8)!
    }
}

extension Encodable {
    func asDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        return jsonObject as? [String: Any]
    }
}
