//
//  PostModel.swift
//  week5_practice
//
//  Created by 정승윤 on 10/22/25.
//

import Foundation

struct PostModel {
    let id: String
    let content: String
    let author: UserModel
    let createdAt: Date
    let likes: Int
    
    // 도메인 로직: 게시물이 최근 게시물인지 확인 (24시간 이내)
    var isRecent: Bool {
        let dayAgo = Date().addingTimeInterval(-86400)
        return createdAt > dayAgo
    }
    
    // 도메인 로직: 표시용 시간 문자열
    var formattedDate: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: createdAt, relativeTo: Date())
    }
}
