
//
//  ShowtimesDTO.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/27/25.
//

import Foundation

struct ShowtimesDTO: Codable, Identifiable, Hashable {
    let id: UUID = UUID()
    let start: String
    let end: String
    let available: Int
    let total: Int
    
    enum CodingKeys: String, CodingKey {
        case start = "start"
        case end = "end"
        case available = "available"
        case total = "total"
    }
}

extension ShowtimesDTO {
    func toDomain() -> ShowtimesDomainModel {
        return ShowtimesDomainModel(
            id: id,
            start: start,
            end: end,
            available: available,
            total: total
        )
    }
}
