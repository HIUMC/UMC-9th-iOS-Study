//
//  UserRouter.swift
//  MegaBox
//
//  Created by 이서현 on 11/8/25.
//

import Foundation
import Moya


enum UserRouter {
    case getMovie(language: String, page: Int, region: String)
}

extension UserRouter: APITargetType {
    var path: String {
        return "/now_playing"
    }
    
    var method: Moya.Method {
        switch self {
        case .getMovie :
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getMovie(let language, let page, let region):
            return .requestParameters(parameters: ["language": language, "page": page, "region": region], encoding: URLEncoding.queryString)
        }
    }   
}
