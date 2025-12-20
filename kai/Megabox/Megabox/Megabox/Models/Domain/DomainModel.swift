//
//  DomainModel.swift
//  Megabox
//
//  Created by 김지우 on 10/30/25.
//

import Foundation

// DTO와 달리, View와 ViewModel에서 사용할 실제 데이터 모델입니다.
// ID를 위한 Identifiable 채택, 날짜/시간은 String이 아닌 'Date' 타입으로 관리합니다.

// 영화 정보 (최상위 모델)
struct Movie: Identifiable, Hashable {
    let id: String // "m-001"
    let title: String
    let ageRating: String // "15", "12" 등
    var schedules: [DailyMovieSchedule]
    let posterAsset: String
}

// 날짜별 상영 일정
struct DailyMovieSchedule: Identifiable, Hashable {
    let id = UUID()
    let date: Date // "2025-09-22" -> Date 객체
    var areas: [AreaSchedule]
}

// 지역별 상영 일정 (예: "강남", "홍대")
struct AreaSchedule: Identifiable, Hashable {
    let id = UUID()
    let areaName: String
    var auditoriums: [AuditoriumItem] // "크리클라이너 1관", "BTS관" 등
}

// 상영관별 아이템
struct AuditoriumItem: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let format: String // "2D", "IMAX"
    var showtimes: [Showtime]
}

// 상영 시간
struct Showtime: Identifiable, Hashable {
    let id = UUID()
    let start: Date // "11:30" -> Date 객체 (날짜 정보 포함)
    let end: Date   // "13:58" -> Date 객체 (날짜 정보 포함)
    let available: Int
    let total: Int
}
