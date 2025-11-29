//
//  Calander.swift
//  MegaBox
//
//  Created by 박병선 on 10/9/25.
//
import Foundation

struct CalendarDay: Identifiable {
    var id: UUID = .init()
    let day: Int
    let date: Date
    let isCurrentMonth: Bool
}
