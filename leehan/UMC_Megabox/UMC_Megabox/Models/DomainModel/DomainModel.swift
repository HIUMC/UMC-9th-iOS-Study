//
//  DomainModel.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/27/25.
//

import Foundation

struct TopDomainModel {
    let status: String
    let msg: String
    let data: MoviesDomainModel
}
extension TopDomainModel {
    func toDTO() -> APIResponse {
        return APIResponse(
            status: status,
            msg: msg,
            data: data.toDTO()
        )
    }
}

struct MoviesDomainModel {
    let movies: [MovieDomainModel]
}
extension MoviesDomainModel {
    func toDTO() -> MoviesDTO {
        return MoviesDTO(
            movies: movies.map { $0.toDTO() }
        )
    }
}

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

struct SchedulesDomainModel {
    let date: String?
    let areas: [AreasDomainModel]
}
extension SchedulesDomainModel {
    func toDTO() -> SchedulesDTO {
        
        guard let date = date else {
            return SchedulesDTO(
                date: "undefined",
                areas: areas.map { $0.toDTO() }
            )
        }
        return SchedulesDTO(
            date: date,
            areas: areas.map { $0.toDTO() }
        )
    }
}

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

struct ItemsDomainModel: Identifiable, Hashable {
    let id: UUID
    let auditorium: String
    let format: String
    let showtimes: [ShowtimesDomainModel]
}
extension ItemsDomainModel {
    func toDTO() -> ItemsDTO {
        return ItemsDTO(
            auditorium: auditorium,
            format: format,
            showtimes: showtimes.map { $0.toDTO() }
        )
    }
}

struct ShowtimesDomainModel: Identifiable, Hashable {
    let id: UUID
    let start: String
    let end: String
    let available: Int
    let total: Int
}
extension ShowtimesDomainModel {
    func toDTO() -> ShowtimesDTO {
        return ShowtimesDTO(
            start: start,
            end: end,
            available: available,
            total: total
        )
    }
}
