//
//  ScheduleDTO.swift
//  MEGABOX
//
//  Created by 정승윤 on 10/26/25.
//

import Foundation

struct ScheduleDTO: Codable {
    let status: String
    let message: String
    let data: MoviesDTO
}

extension ScheduleDTO {
    func toDomain() -> ScheduleModel {
        return ScheduleModel(
            status: status,
            message: message,
            data: data.toDomain()
        )
    }
}

struct MoviesDTO: Codable {
    let movies : [MovieDTO]
}

extension MoviesDTO {
    // DTO를 도메인 모델로 변환
    func toDomain() -> MoviesModel {
        return MoviesModel(
            movies: movies.map { $0.toDomain() }
        )
    }
}

struct MovieDTO: Codable {
    let id: String
    let title: String
    let ageRating: String
    let schedules: [DateDTO]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case ageRating = "age_rating"
        case schedules
    }
}

extension MovieDTO {
    func toDomain() -> AMovieModel {
        return AMovieModel(
            id: id,
            title: title,
            ageRating: ageRating,
            schedules: schedules.map { $0.toDomain() }
        )
    }
}

struct DateDTO: Codable {
    let date: Date
    let areas: [AreaDTO]
}

extension DateDTO {
    func toDomain() -> DateModel {
        return DateModel(
            date: date,
            areas: areas.map { $0.toDomain() }
        )
    }
}

struct AreaDTO: Codable {
    let area: String
    let items: [TimeDTO]
}

extension AreaDTO {
    func toDomain() -> AreaModel {
        return AreaModel(
            area: area,
            items: items.map { $0.toDomain() }
        )
    }
}

struct TimeDTO: Codable {
    let auditorium: String
    let format: String
    let showtimes: [ShowTimesDTO]
}

extension TimeDTO {
    func toDomain() -> TimeModel {
        return TimeModel(
            auditorium: auditorium,
            format: format,
            showtimes: showtimes.map { $0.toDomain() }
        )
    }
}

struct ShowTimesDTO: Codable {
    let start: String
    let end: String
    let available: Int
    let total: Int
}

extension ShowTimesDTO {
    func toDomain() -> ShowTimeModel {
        return ShowTimeModel(
            start: start,
            end: end,
            available: available,
            total: total
        )
    }
}
