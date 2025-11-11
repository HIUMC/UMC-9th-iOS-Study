//
//  CommentModel.swift
//  week5_practice
//
//  Created by 정승윤 on 10/22/25.
//

import Foundation

struct CommentModel {
    let id: String
    let content: String
    let author: UserModel
    let createdAt: Date
    
    // 도메인 로직: 댓글이 수정 가능한지 확인 (작성 후 5분 이내)
    var isEditable: Bool {
        let fiveMinutesAgo = Date().addingTimeInterval(-300)
        return createdAt > fiveMinutesAgo
    }
}
