//
//  APIResponse.swift
//  week5_practice
//
//  Created by 이서현 on 10/25/25.
//

import Foundation

struct APIResponse: Codable {
    let status: String
    let message: String
    let data: UserData
}

struct UserData: Codable {
    let users: [UserDTO]
}
