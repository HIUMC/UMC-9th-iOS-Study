//
//  MovieScheduleDTO.swift
//  MEGABOX
//
//  Created by 고석현 on 11/6/25.
//

import Foundation


struct APIResponse: Codable {
    let status: String
    let msg: String
    let data: MoviesDTO

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case msg = "message"
        case data = "data"
    }
}
extension APIResponse {
    func toDomain() -> TopDomainModel {
        return TopDomainModel(
            status: status,
            msg: msg,
            data: data.toDomain()
        )
    }
}

struct MoviesDTO: Codable {
    let movies: [MovieDTO]

    enum CodingKeys: String, CodingKey {
        case movies = "movies"
    }
}
extension MoviesDTO {
    func toDomain() -> MoviesDomainModel {
        return MoviesDomainModel(
            movies: movies.map { $0.toDomain() }
        )
    }
}

struct MovieDTO: Codable {
    let id: String
    let title: String
    let age: String
    let schedules: [SchedulesDTO]

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case age = "age_rating"
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

struct SchedulesDTO: Codable {
    let date: String?
    let areas: [AreasDTO]

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
                areas: areas.map { $0.toDomain() }
            )
        }
        return SchedulesDomainModel(
            date: date,
            areas: areas.map { $0.toDomain() }
        )
    }
}

struct AreasDTO: Codable {
    let id: UUID = UUID()
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
            id: id,
            area: area,
            items: items.map { $0.toDomain() }
        )
    }
}

struct ItemsDTO: Codable, Identifiable, Hashable {
    let id: UUID = UUID()
    let auditorium: String
    let format: String
    let showtimes: [ShowtimesDTO]

    enum CodingKeys: String, CodingKey {
        case auditorium = "auditorium"
        case format = "format"
        case showtimes = "showtimes"
    }
}
extension ItemsDTO {
    func toDomain() -> ItemsDomainModel {
        return ItemsDomainModel(
            id: id,
            auditorium: auditorium,
            format: format,
            showtimes: showtimes.map { $0.toDomain() }
        )
    }
}

struct ShowtimesDTO: Codable, Identifiable, Hashable {
    let id: UUID = UUID()
    let start: String
    let end: String
    let available: Int
    let total: Int

    enum CodingKeys: String, CodingKey {
        case start = "start"
        case end = "end"
        case available = "available"
        case total = "total"
    }
}
extension ShowtimesDTO {
    func toDomain() -> ShowtimesDomainModel {
        return ShowtimesDomainModel(
            id: id,
            start: start,
            end: end,
            available: available,
            total: total
        )
    }
}


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
