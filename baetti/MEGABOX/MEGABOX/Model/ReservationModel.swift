//
//  ReservationModel.swift
//  MEGABOX
//
//  Created by 박정환 on 10/8/25.
//

import Foundation

public struct DayItem: Hashable, Identifiable {
    public let id = UUID()
    public let date: Date

    public var dateLabel: String {
        let df = DateFormatter()
        df.dateFormat = "d"       // 일만 출력
        return df.string(from: date)
    }

    public var weekdayLabel: String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "E"
        return df.string(from: date)
    }

    public static func today() -> DayItem { DayItem(date: Date()) }
    public static func thisWeek(from start: Date = Date()) -> [DayItem] {
        (0..<7).compactMap { Calendar.current.date(byAdding: .day, value: $0, to: start) }
            .map { DayItem(date: $0) }
    }
}
