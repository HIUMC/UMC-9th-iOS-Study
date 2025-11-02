//
//  AreasDomainModel.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/27/25.
//

import Foundation

struct AreasDomainModel: Identifiable, Hashable {
    let id: UUID
    let area: String
    let items: [ItemsDomainModel]
}

extension AreasDomainModel {
    func toDTO() -> AreasDTO {
        return AreasDTO(
            area: area,
            items: items.map { $0.toDTO() }
        )
    }
}
