//
//  MoyaModel.swift
//  TestMoya
//
//  Created by 정승윤 on 11/12/25.
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


