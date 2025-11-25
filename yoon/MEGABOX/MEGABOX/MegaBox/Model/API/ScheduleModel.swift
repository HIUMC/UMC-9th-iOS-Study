//
//  ScheduleModel.swift
//  MEGABOX
//
//  Created by 정승윤 on 10/26/25.
//

import Foundation

struct ScheduleModel {
    let status: String
    let message: String
    let data: MoviesModel
}

struct MoviesModel {
    let movies: [AMovieModel]
}

struct AMovieModel {
    let id: String
    let title: String
    let ageRating: String
    let schedules: [DateModel]
}

struct DateModel {
    let date: Date
    let areas: [AreaModel]
}

struct AreaModel {
    let area: String
    let items: [TimeModel]
}

struct TimeModel {
    let auditorium: String
    let format: String
    let showtimes: [ShowTimeModel]
}

struct ShowTimeModel {
    let start: String
    let end: String
    let available: Int
    let total: Int
}
