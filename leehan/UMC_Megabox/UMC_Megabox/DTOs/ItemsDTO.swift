//
//  ItemsDTO.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/27/25.
//

import Foundation

struct ItemsDTO: Codable {
    let auditorium: String
    let format: String
    let showtimes: ShowtimesDTO
    
    enum CodingKeys: String, CodingKey {
        case auditorium = "auditorium"
        case format = "format"
        case showtimes = "showtimes"
    }
}

extension ItemsDTO {
    func toDomain() -> ItemsDomainModel {
        return ItemsDomainModel(
            auditorium: auditorium,
            format: format,
            showtimes: showtimes.toDomain()
        )
    }
}
