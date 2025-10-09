//
//  CalenderModel.swift
//  MEGABOX
//
//  Created by 정승윤 on 10/8/25.
//

import Foundation

struct CalendarDay: Identifiable {
    var id: UUID = .init()
    let day: Int
    let date: Date
    let isCurrentMonth: Bool
}
