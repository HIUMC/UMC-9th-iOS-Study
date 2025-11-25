//
//  CalenderDay.swift
//  MEGABOX
//
//  Created by 고석현 on 10/9/25.
//

import Foundation
import SwiftUI

struct CalendarDay: Identifiable {
    var id: UUID = .init()
    let day: Int
    let date: Date
    let isCurrentMonth: Bool
}
