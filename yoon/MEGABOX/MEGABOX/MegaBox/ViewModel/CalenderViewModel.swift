//
//  CalenderViewModel.swift
//  MEGABOX
//
//  Created by 정승윤 on 10/8/25.
//

import Foundation
import Combine


class CalendarViewModel: ObservableObject {
    var calendar: Calendar = .current
    @Published var selectedDate: Date = Date()
    
        private let fixedStartDate: Date = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // UTC 자정 고정
            
            return dateFormatter.date(from: "2025-09-22") ?? Date()
        }()
    
    /// 오늘 기준 일주일 날짜 생성
    func currentWeekDates() -> [CalendarDay] {
        var days: [CalendarDay] = []
        let startDay = fixedStartDate
        for i in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: i, to: startDay) {
                let day = calendar.component(.day, from: date)
                days.append(CalendarDay(day: day, date: date, isCurrentMonth: true))
            }
        }
        return days
    }
    
    /// 선택 날짜 변경
    func selectDate(_ date: Date) {
        let components = calendar.dateComponents([.year, .month, .day], from: date)
            
            if let cleanDate = calendar.date(from: components) {
                selectedDate = cleanDate
            } else {
                selectedDate = date
            }
    }
}
