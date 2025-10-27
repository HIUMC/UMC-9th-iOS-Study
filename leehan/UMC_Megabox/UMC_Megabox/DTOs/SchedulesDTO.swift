//
//  SchedulesDTO.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/27/25.
//

import Foundation

struct SchedulesDTO: Codable {
    let date: String?
    let areas: AreasDTO
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case areas = "areas"
    }
}

extension SchedulesDTO {
    func toDomain() -> SchedulesDomainModel {
        
        guard let date = date else {
            return SchedulesDomainModel(
                date: "undefined",
                areas: areas.toDomain()
            )
        }
            
        return SchedulesDomainModel(
            date: date,
            areas: areas.toDomain()
        )
    }
}
