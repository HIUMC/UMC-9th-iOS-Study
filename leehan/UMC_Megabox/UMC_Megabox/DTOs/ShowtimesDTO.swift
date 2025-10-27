//
//  ShowtimesDTO.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/27/25.
//

import Foundation

struct ShowtimesDTO: Codable {
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
            start: start,
            end: end,
            available: available,
            total: total
        )
    }
}
