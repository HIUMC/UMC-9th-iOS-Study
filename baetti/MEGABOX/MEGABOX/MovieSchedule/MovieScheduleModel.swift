//
//  DomainModel.swift
//  MEGABOX
//
//  Created by 박정환 on 11/2/25.
//

import Foundation

struct Movie {
    let id: String
    let title: String
    let ageRating: String
    let schedules: [MovieSchedule]
}

struct MovieSchedule {
    let date: Date
    let areas: [ScheduleArea]
}

struct ScheduleArea {
    let area: String
    let items: [TheaterItem]
}

struct TheaterItem {
    let auditorium: String
    let format: String
    let showtimes: [Showtime]
}

struct Showtime {
    let start: String
    let end: String
    let available: Int
    let total: Int
}
