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
    
    /// 오늘 기준 일주일 날짜 생성
    func currentWeekDates() -> [CalendarDay] {
        var days: [CalendarDay] = []
        let today = Date()
        
        for i in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: i, to: today) {
                let day = calendar.component(.day, from: date)
                days.append(CalendarDay(day: day, date: date, isCurrentMonth: true))
            }
        }
        return days
    }
    
    /// 선택 날짜 변경
    func selectDate(_ date: Date) {
        selectedDate = date
    }
}
