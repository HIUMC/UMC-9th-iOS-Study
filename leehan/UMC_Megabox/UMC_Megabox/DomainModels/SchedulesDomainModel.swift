//
//  SchedulesDomainModel.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/27/25.
//

import Foundation

struct SchedulesDomainModel {
    let date: String?
    let areas: AreasDomainModel
}

extension SchedulesDomainModel {
    func toDTO() -> SchedulesDTO {
        
        guard let date = date else {
            return SchedulesDTO(
                date: "undefined",
                areas: areas.toDTO()
            )
        }
        
        return SchedulesDTO(
            date: date,
            areas: areas.toDTO()
        )
    }
}
