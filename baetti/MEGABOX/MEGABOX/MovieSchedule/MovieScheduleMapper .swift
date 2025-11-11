//
//  Mapper.swift
//  MEGABOX
//
//  Created by 박정환 on 11/2/25.
//

import Foundation

extension MovieDTO {
    func toDomain() -> Movie {
        Movie(
            id: id,
            title: title,
            ageRating: ageRating,
            schedules: schedules.map { $0.toDomain() }
        )
    }
}

extension ScheduleDTO {
    func toDomain() -> MovieSchedule {
        // 날짜 문자열을 Date로 변환
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let parsedDate = formatter.date(from: date) ?? Date()

        return MovieSchedule(
            date: parsedDate,
            areas: areas.map { $0.toDomain() }
        )
    }
}

extension AreaDTO {
    func toDomain() -> ScheduleArea {
        ScheduleArea(
            area: area,
            items: items.map { $0.toDomain() }
        )
    }
}

extension TheaterItemDTO {
    func toDomain() -> TheaterItem {
        TheaterItem(
            auditorium: auditorium,
            format: format,
            showtimes: showtimes.map { $0.toDomain() }
        )
    }
}

extension ShowtimeDTO {
    func toDomain() -> Showtime {
        Showtime(
            start: start,
            end: end,
            available: available,
            total: total
        )
    }
}
