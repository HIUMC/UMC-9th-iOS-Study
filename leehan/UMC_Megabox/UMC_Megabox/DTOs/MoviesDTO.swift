//
//  MoviesDTO.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/27/25.
//

import Foundation

struct MoviesDTO: Codable {
    let id: String
    let title: String
    let age: Int
    let schedules: SchedulesDTO
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case age = "age-rating"
        case schedules = "schedules"
    }
}

extension MoviesDTO {
    func toDomain() -> MoviesDomainModel {
        return MoviesDomainModel(
            id: id,
            title: title,
            age: age,
            schedules: schedules.toDomain()
        )
    }
}
