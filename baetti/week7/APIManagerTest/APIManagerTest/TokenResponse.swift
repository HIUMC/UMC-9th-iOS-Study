//
//  TokenResponse.swift
//  APIManagerTest
//
//  Created by 박정환 on 11/11/25.
//

import Foundation

struct TokenResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: UserInfo
}
