//
//  TokenKeychain.swift
//  MegaBox
//
//  Created by 박병선 on 11/13/25.
//
import Foundation

// 비동기 환경에서 토큰을 안전하게 관리하고 갱신하기 위한 목적으로 작성
protocol TokenProviding {
    var accessToken: String? { get set }
    func refreshToken(completion: @escaping (String?, Error?) -> Void)
}

struct TokenInfo: Codable {
    var accessToken: String
    var refreshToken: String
}
