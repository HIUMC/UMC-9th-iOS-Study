//
//  MovieScheduleDTO.swift
//  MegaBox
//
//  Created by 이서현 on 10/25/25.
//

import Foundation

struct APIResponse: Codable {
    let status: String
    let message: String
    let data: MovieDataContainer
}

struct MovieDataContainer: Codable {
    let movies: [MovieData]
}


struct MovieData: Codable {
    let id: String
    let title: String
    let age_rating: String
    let schedules: [MovieScheduleDTO]
}

struct MovieScheduleDTO: Codable {
    let date: String
    let areas: [MovieScheduleAreaDTO]
}


struct MovieScheduleAreaDTO: Codable {
    let area: String
    let items: [MovieAuditoriumDTO]
}

struct MovieAuditoriumDTO: Codable {
    let auditorium: String
    let format: String
    let showtimes: [MovieShowtimeDTO]
}

struct MovieShowtimeDTO: Codable {
    let start: String
    let end: String
    let available: Int
    let total: Int
}

struct MovieShowtimeGroup {
    let movie: MovieModel
    let showtimes: [Showtime]
}



/*
 "status": "success",
 "message": "Showtimes fetched successfully",
 "data": {
     "movies": [
         {
             "id": "m-001",
             "title": "어쩔수가없다",
             "age_rating": "15",
             "schedules": [
                 {
                     "date": "2025-09-22",
                     "areas": [
                         {
                             "area": "강남",
                             "items": [
                                 {
                                     "auditorium": "크리클라이너 1관",
                                     "format": "2D",
                                     "showtimes": [
                                         { "start": "11:30", "end": "13:58", "available": 109, "total": 116 },
                                         { "start": "14:20", "end": "16:48", "available": 19,  "total": 116 },
                                         { "start": "17:05", "end": "19:28", "available": 1,   "total": 116 },
                                         { "start": "19:45", "end": "22:02", "available": 100, "total": 116 },
                                         { "start": "22:20", "end": "00:04", "available": 116, "total": 116 }
                                     ]
                                 }
                             ]
                         }
 */

