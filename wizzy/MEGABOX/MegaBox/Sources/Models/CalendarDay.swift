//
//  CalendarDay.swift
//  MegaBox
//
//  Created by 이서현 on 10/5/25.
//

import Foundation


struct CalendarDay: Identifiable {
    var id: UUID = .init()
    let day: Int
    let date: Date
    let isCurrentMonth: Bool
}
