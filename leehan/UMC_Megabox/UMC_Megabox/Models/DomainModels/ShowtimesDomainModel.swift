//
//  ShowtimesDomainModel.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/27/25.
//

import Foundation

struct ShowtimesDomainModel: Identifiable, Hashable {
    let id: UUID
    let start: String
    let end: String
    let available: Int
    let total: Int
}

extension ShowtimesDomainModel {
    func toDTO() -> ShowtimesDTO {
        return ShowtimesDTO(
            start: start,
            end: end,
            available: available,
            total: total
        )
    }
}
