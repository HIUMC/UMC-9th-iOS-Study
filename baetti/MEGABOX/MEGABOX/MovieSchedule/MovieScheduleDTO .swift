//
//  DTO.swift
//  MEGABOX
//
//  Created by 박정환 on 11/2/25.
//

// MARK: - Root Response
struct MovieResponseDTO: Codable {
    let status: String
    let message: String
    let data: MovieDataDTO
}

// MARK: - data
struct MovieDataDTO: Codable {
    let movies: [MovieDTO]
}

// MARK: - movies[]
struct MovieDTO: Codable {
    let id: String
    let title: String
    let ageRating: String
    let schedules: [ScheduleDTO]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case ageRating = "age_rating"
        case schedules
    }
}

// MARK: - schedules[]
struct ScheduleDTO: Codable {
    let date: String
    let areas: [AreaDTO]
}

// MARK: - areas[]
struct AreaDTO: Codable {
    let area: String
    let items: [TheaterItemDTO]
}

// MARK: - items[]
struct TheaterItemDTO: Codable {
    let auditorium: String
    let format: String
    let showtimes: [ShowtimeDTO]
}

// MARK: - showtimes[]
struct ShowtimeDTO: Codable {
    let start: String
    let end: String
    let available: Int
    let total: Int
}
