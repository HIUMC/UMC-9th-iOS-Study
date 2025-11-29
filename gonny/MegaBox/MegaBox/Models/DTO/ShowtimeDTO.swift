//
//  ShowtimesResponse.swift
//  MegaBox
//
//  Created by 박병선 on 10/30/25.
//
import Foundation

// MARK: - 최상위 응답 DTO
struct ShowtimesResponse: Codable {
    let status: String
    let message: String
    let data: ShowtimesPayload
}

// MARK: - data 객체
struct ShowtimesPayload: Codable {
    let movies: [MovieDTO]
}

// MARK: - 영화 정보
struct MovieDTO: Codable, Identifiable, Hashable {
    let id: String
    let title: String
    let ageRating: String
    let schedules: [ScheduleDTO]

    enum CodingKeys: String, CodingKey {
        case id, title, schedules
        case ageRating = "age_rating"
    }
}

extension MovieDTO {
    //DTO를 도메인모델로 변환
    func toDomain() -> ShowtimeMovie {
        ShowtimeMovie(
            id: id,
            title: title,
            ageRating: ageRating,
            schedules: schedules.map { $0.toDomain() }
        )
    }
}

// MARK: - 상영 일정
struct ScheduleDTO: Codable, Hashable {
    let date: String
    let areas: [AreaScheduleDTO]
}

extension ScheduleDTO {
    func toDomain() -> ShowtimeSchedule {
        ShowtimeSchedule(
            date: date,
            areas: areas.map { $0.toDomain() }
        )
    }
}

// MARK: - 지역별 상영관
struct AreaScheduleDTO: Codable, Hashable {
    let area: String
    let items: [AuditoriumDTO]
}

extension AreaScheduleDTO {
    func toDomain() -> ShowtimeArea {
        ShowtimeArea(
            area: area,
            items: items.map { $0.toDomain() }
        )
    }
}

// MARK: - 상영관 및 포맷
struct AuditoriumDTO: Codable, Hashable {
    let auditorium: String
    let format: String
    let showtimes: [ShowtimeDTO]
}

extension AuditoriumDTO {
    func toDomain() -> ShowtimeAuditorium {
        ShowtimeAuditorium(
            auditorium: auditorium,
            format: format,
            showtimes: showtimes.map { $0.toDomain() }
        )
    }
}

// MARK: - 시간표 세부
struct ShowtimeDTO: Codable, Hashable {
    let start: String
    let end: String
    let available: Int
    let total: Int
}

extension ShowtimeDTO {
    func toDomain() -> ShowtimeSlot {
        ShowtimeSlot(start: start, end: end, available: available, total: total)
    }
}

