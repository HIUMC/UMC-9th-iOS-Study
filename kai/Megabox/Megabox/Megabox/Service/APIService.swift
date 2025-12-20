//
//  APIService.swift
//  Megabox
//
//  Created by 김지우 on 11/13/25.
//


import Foundation
import Moya

//API 키를 Bundle에서 읽어오는 Helper
extension Bundle {
    var apiKey: String {
        guard let key = object(forInfoDictionaryKey: "TMDB API Key") as? String else {
            fatalError("Info.plist에 'TMDB API Key'가 설정되지 않았습니다.")
        }
        return key
    }
}

//엔드포인트 정의
enum TMDBAPI {
    case nowPlaying(language: String, page: Int, region: String)
    
    //movieID와 language를 파라미터로 받도록 변경
    case getMovieDetails(movieID: Int, language: String)
}

//TargetType 프로토콜
extension TMDBAPI: TargetType {
    
    //BaseURL
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org")!
    }
    
    //세부 경로 (Path)
    var path: String {
        switch self {
        case .nowPlaying:
            return "/3/movie/now_playing"
        case .getMovieDetails(let movieID, _):
            return "/3/movie/\(movieID)" // 예: /3/movie/1234
        }
    }
    
    //HTTP Method
    var method: Moya.Method {
        switch self {
        //  두 케이스 모두 .get을 사용
        case .nowPlaying, .getMovieDetails:
            return .get
        }
    }
    
    //Task
    var task: Moya.Task {
        //통 파라미터(api_key)를 미리 정의
        let commonParams = ["api_key": Bundle.main.apiKey]
        
        switch self {
        case .nowPlaying(let language, let page, let region):
            //공통 파라미터와 합치기
            var params = commonParams
            params["language"] = language
            params["page"] = "\(page)"
            params["region"] = region
            
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .getMovieDetails(_, let language):
            //getMovieDetails에 대한 task 구현
            var params = commonParams
            params["language"] = language
            
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    //HTTP 헤더
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}

//MoyaProvider를 async/await로 호출할 APIManager
final class APIManager {
    
    static let shared = APIManager()
    
    //로그 플러그인 설정을 .verbose로 변경 (더 자세한 로그)
    private let provider = MoyaProvider<TMDBAPI>(
        plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))]
    )
    
    private init() {}
    
    // 제네릭(<T>)과 Decodable을 사용해, 어떤 응답 DTO든 처리할 수 있는 만능 함수
    func request<T: Decodable>(_ target: TMDBAPI) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(target) { result in
                switch result {
                case .success(let response):
                    do {

                        let decoder = JSONDecoder()
                        
                        
                        let decodedData = try decoder.decode(T.self, from: response.data)
                        
                        continuation.resume(returning: decodedData)
                        
                    } catch let error {
                        // 디코딩 실패
                        print("[Moya Decoder Error] @ \(target):", error)
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    // 네트워크 통신 실패
                    print("[Moya Network Error] @ \(target):", error)
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
