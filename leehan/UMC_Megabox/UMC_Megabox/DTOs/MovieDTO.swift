//
//  MovieDTO.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/28/25.
//

import Foundation

struct MovieDTO: Codable {
    let id: String
    let title: String
    let age: String
    let schedules: [SchedulesDTO]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case age = "age-rating"
        case schedules = "schedules"
    }
}

extension MovieDTO {
    func toDomain() -> MovieDomainModel {
        return MovieDomainModel(
            id: id,
            title: title,
            age: Int(age) ?? 0,
            schedules: schedules.map { $0.toDomain() }
        )
    }
}
