//
//  USer.swift
//  week5_practice
//
//  Created by 김지우 on 11/4/25.
//

import Foundation

// 뷰와 뷰모델에서 사용할 '최종' 데이터 모델
struct User: Identifiable {
    
    // 1. DTO로부터 변환된 '상태'
    let id: String
    let name: String
    let profileImageURL: String?
    let bio: String
    let createdAt: Date // String에서 Date로 변환됨

    // 2. 앱에서만 사용하는 '로직' (기존 UserModel의 장점)
    var isProfileComplete: Bool {
        !name.isEmpty && !bio.isEmpty
    }
    
    var displayName: String {
        name.isEmpty ? "익명 사용자" : name
    }
}
