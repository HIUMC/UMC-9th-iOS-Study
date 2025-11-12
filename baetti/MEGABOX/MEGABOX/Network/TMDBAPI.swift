//
//  TMDBAPI.swift
//  MEGABOX
//
//  Created by 박정환 on 11/12/25.
//

import Foundation
import Moya
import Alamofire

enum TMDBAPI {
    case nowPlaying(page: Int)
}

extension TMDBAPI: TargetType {
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
        case .nowPlaying(let page):
            // API Key를 쿼리 파라미터에 추가
            let parameters: [String: Any] = [
                "api_key": Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? "",
                "language": "ko-KR",
                "page": page,
                "region": "KR"
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return ["accept": "application/json"]
    }

    var sampleData: Data {
        return Data()
    }
}
