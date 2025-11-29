//
//  UserData.swift
//  APIManagerTest
//
//  Created by 박정환 on 11/11/25.
//

import Foundation

struct UserData: Codable {
    let name: String
    let age: Int
    let address: String
    let height: Double
}

struct UserPatchRequest: Codable {
    let name: String?
    let age: Int?
    let address: String?
    let height: Double?
}
