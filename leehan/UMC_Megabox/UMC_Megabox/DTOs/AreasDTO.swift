//
//  AreasDTO.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/27/25.
//

import Foundation

struct AreasDTO: Codable {
    let area: String
    let items: [ItemsDTO]
    
    enum CodingKeys: String, CodingKey {
        case area = "area"
        case items = "items"
    }
}

extension AreasDTO {
    func toDomain() -> AreasDomainModel {
        return AreasDomainModel(
            area: area,
            items: items.map { $0.toDomain() }
        )
    }
}
