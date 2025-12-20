//
//  MovieDTO.swift
//  Megabox
//
//  Created by 김지우 on 10/30/25.
//

import Foundation

// API 응답의 전체 구조
struct APIResponseDTO: Codable {
    let status: String
    let message: String
    let data: MovieDataDTO
}

// "data" 필드
struct MovieDataDTO: Codable {
    let movies: [MovieDTO]
}

// "movies" 배열 요소
struct MovieDTO: Codable {
    let id: String
    let title: String
    let age_rating: String
    let schedules: [DailyScheduleDTO]
}

// "schedules" 배열 요소 (날짜별)
struct DailyScheduleDTO: Codable {
    let date: String // "2025-09-22"
    let areas: [AreaDTO]
}

// "areas" 배열 요소
struct AreaDTO: Codable {
    let area: String // "강남", "홍대"
    let items: [AuditoriumItemDTO]
}

// "items" 배열 요소 (상영관별)
struct AuditoriumItemDTO: Codable {
    let auditorium: String
    let format: String
    let showtimes: [ShowtimeDTO]
}

// "showtimes" 배열 요소
struct ShowtimeDTO: Codable {
    let start: String // "11:30"
    let end: String   // "13:58"
    let available: Int
    let total: Int
}
