//
//  UserDTO.swift
//  week5_practice
//
//  Created by 김지우 on 11/4/25.
//

import Foundation

struct UserDTO: Codable{
    let userID: String
    let name: String
    let profileImage: String?
    let userBio: String
    let createdAt: String
    
    enum CodingKeys: String, CodingKey{
        case userID = "user_id"
        case name = "user_name"
        case profileImage = "profile_image"
        case userBio = "user_bio"
        case createdAt = "created_at"
    }
}



