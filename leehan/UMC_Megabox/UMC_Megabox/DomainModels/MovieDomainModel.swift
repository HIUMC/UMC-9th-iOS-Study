//
//  MovieDomainModel.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/28/25.
//

import Foundation

struct MovieDomainModel {
    let id: String
    let title: String
    let age: Int
    let schedules: [SchedulesDomainModel]
}

extension MovieDomainModel {
    func toDTO() -> MovieDTO {
        return MovieDTO(
            id: id,
            title: title,
            age: String(age),
            schedules: schedules.map { $0.toDTO() }
        )
    }
}
