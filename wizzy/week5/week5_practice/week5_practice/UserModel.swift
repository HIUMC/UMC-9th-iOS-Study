//
//  UserModel.swift
//  week5_practice
//
//  Created by 이서현 on 10/25/25.
//

import Foundation

struct UserModel {
    let id: String
    let name: String
    let profileImageURL: String?
    let bio: String
    
    var isProfileComplete: Bool {
        !name.isEmpty && !bio.isEmpty
    }
    
    var displayName: String {
        name.isEmpty ? "익명 사용자" : name
    }
}
