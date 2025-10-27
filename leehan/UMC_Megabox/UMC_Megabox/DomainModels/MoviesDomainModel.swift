//
//  MoviesDomainModel.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/27/25.
//

import Foundation

struct MoviesDomainModel {
    let id: String
    let title: String
    let age: Int
    let schedules: SchedulesDomainModel
}

extension MoviesDomainModel {
    func toDTO() -> MoviesDTO {
        return MoviesDTO(
            id: id,
            title: title,
            age: age,
            schedules: schedules.toDTO()
        )
    }
}
