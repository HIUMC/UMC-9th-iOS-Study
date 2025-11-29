//
//  ShowtimeModel.swift
//  MegaBox
//
//  Created by 박병선 on 10/30/25.
//
import Foundation

struct ShowtimeMovie: Identifiable, Hashable {
    let id: String
    let title: String
    let ageRating: String
    let schedules: [ShowtimeSchedule]
}

struct ShowtimeSchedule: Hashable {
    let date: String                // "yyyy-MM-dd" 그대로 둠(뷰모델에서 필요 시 Date 변환)
    let areas: [ShowtimeArea]
}

struct ShowtimeArea: Hashable {
    let area: String                // "강남", "홍대"
    let items: [ShowtimeAuditorium]
}

struct ShowtimeAuditorium: Hashable {
    let auditorium: String          // "IMAX 1관" 등
    let format: String              // "2D", "IMAX"...
    let showtimes: [ShowtimeSlot]
}

struct ShowtimeSlot: Hashable {
    let start: String               // "11:30"
    let end: String                 // "13:58"
    let available: Int
    let total: Int
    var reserved: Int { max(total - available, 0) }
    var soldOut: Bool { available == 0 }
    var rate: Double { total == 0 ? 0 : Double(reserved) / Double(total) }
}
