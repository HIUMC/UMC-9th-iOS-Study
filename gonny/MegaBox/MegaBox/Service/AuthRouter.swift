//
//  AuthRouter.swift
//  MegaBox
//
//  Created by 박병선 on 11/13/25.
//
// 인증(Auth) 관련 API endpoint들을 한곳에 모아둔 enum
import Foundation
import Moya
import Alamofire

enum AuthRouter : APITargetType {
    case sendRefreshToken(refreshToken: String) // 리프레시 토큰 갱신
}

extension AuthRouter {
    var path: String {
        switch self {
        case .sendRefreshToken:
            return "/member/reissue"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .sendRefreshToken:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .sendRefreshToken:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .sendRefreshToken(let refresh):
            var headers = ["Content-Type": "application/json"]
            headers["Refresh-Token"] = "\(refresh)"
            
            return headers
        }
    }
}
