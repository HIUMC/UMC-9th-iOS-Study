//
//  ItemsDomainModel.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/27/25.
//

import Foundation

struct ItemsDomainModel {
    let auditorium: String
    let format: String
    let showtimes: ShowtimesDomainModel
}

extension ItemsDomainModel {
    func toDTO() -> ItemsDTO {
        return ItemsDTO(
            auditorium: auditorium,
            format: format,
            showtimes: showtimes.toDTO()
        )
    }
}

