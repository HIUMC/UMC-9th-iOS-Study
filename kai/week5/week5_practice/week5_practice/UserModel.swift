//
//  UserModel.swift
//  week5_practice
//
//  Created by 김지우 on 11/4/25.
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
