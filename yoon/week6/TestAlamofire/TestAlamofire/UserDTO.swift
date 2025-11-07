//
//  UserDTO.swift
//  TestAlamofire
//
//  Created by 정승윤 on 11/5/25.
//

import Foundation

nonisolated struct UserDTO: Codable {
    let name: String
    let age: Int
    let address: String
    let height: Double
}
