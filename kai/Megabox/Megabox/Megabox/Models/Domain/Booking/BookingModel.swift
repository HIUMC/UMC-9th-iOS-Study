//
//  BookingModel.swift
//  Megabox
//
//  Created by 김지우 on 10/9/25.
//

import Foundation

enum Theater: String, CaseIterable, Hashable {
    case gangnam = "강남"
    case hongdae = "홍대"
    case sinchon = "신촌"
}

struct BookingMovie: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let posterAsset: String
    let ageBadge: String?   // 예: "15"
}

struct ShowTime: Identifiable, Hashable {
    let id = UUID()
    let time: String       // "10:20"
    let screen: String     // "1관"
    let seatsLeft: Int     // 잔여 좌석
}
