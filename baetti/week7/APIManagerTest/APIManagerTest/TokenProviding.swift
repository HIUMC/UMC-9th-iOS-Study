//
//  TokenProviding.swift
//  APIManagerTest
//
//  Created by 박정환 on 11/11/25.
//


// 비동기 환경에서 토큰을 안전하게 관리하고 갱신하기 위한 목적

import Foundation

protocol TokenProviding {
    var accessToken: String? { get set }
    func refreshToken(completion: @escaping (String?, Error?) -> Void)
}
