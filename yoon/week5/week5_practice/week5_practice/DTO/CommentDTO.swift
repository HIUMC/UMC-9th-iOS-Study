//
//  CommentDTO.swift
//  week5_practice
//
//  Created by 정승윤 on 10/22/25.
//

import Foundation

// CommentDTO
struct CommentDTO: Codable {
    let comment_id: String
    let text: String
    let user: UserDTO
    let timestamp: String
}

struct CommentMapper {
    static func toDomain(from dto: CommentDTO) -> CommentModel {
        let dateFormatter = ISO8601DateFormatter()
        let createdAt = dateFormatter.date(from: dto.timestamp) ?? Date()
        
        return CommentModel(
            id: dto.comment_id,
            content: dto.text,
            author: dto.user.toDomain(),
            createdAt: createdAt
        )
    }
}
