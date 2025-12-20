//
//  UserMapper.swift
//  week5_practice
//
//  Created by 김지우 on 11/4/25.
//

import Foundation

struct UserMapper {
    
    // 1. 날짜 변환기 (String <-> Date)
    // (static let으로 한 번만 생성해서 재사용)
    private static let dateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        // DTO의 "createdAt" 문자열 형식에 맞춰 옵션을 조정해야 할 수 있습니다.
        // 예: "2025-11-04T10:30:00Z"
        formatter.formatOptions = [.withInternetDateTime]
        return formatter
    }()

    // 2. [toDomain] DTO -> Domain (오류 수정)
    // - 반환 타입을 'User'로 수정
    // - 'dto.' 접두사로 DTO 프로퍼티에 접근
    // - 'User' 모델의 이니셜라이저 사용
    static func toDomain(from dto: UserDTO) -> User {
        
        // DTO의 String을 Date로 변환
        let createdAtDate = dateFormatter.date(from: dto.createdAt) ?? Date() // 파싱 실패 시 현재 날짜

        return User(
            id: dto.userID,
            name: dto.name,
            profileImageURL: dto.profileImage,
            bio: dto.userBio,
            createdAt: createdAtDate // 변환된 Date 객체 주입
        )
    }
     
    // 3. [toDTO] Domain -> DTO (오류 수정)
    // - UserDTO의 정확한 이니셜라이저 파라미터 이름 사용
    // - domain.createdAt을 다시 String으로 변환
    static func toDTO(from domain: User) -> UserDTO {
        
        // Domain의 Date를 다시 String으로 변환
        let createdAtString = dateFormatter.string(from: domain.createdAt)

        return UserDTO(
            userID: domain.id,
            name: domain.name,
            profileImage: domain.profileImageURL,
            userBio: domain.bio,
            createdAt: createdAtString
        )
    }
     
    // 'toDomain' 함수가 수정되어 이제 정상 작동합니다.
    static func toDomainList(from dtos: [UserDTO]) -> [User] {
        return dtos.map { toDomain(from: $0) }
    }
}
