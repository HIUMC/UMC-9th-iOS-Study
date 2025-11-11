//
//  MovieModel.swift
//  MegaBox
//
//  Created by 이서현 on 9/29/25.
//

import Foundation

struct MovieModel: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let poster: String
    let countAudience: String?
}


enum Theater: String, CaseIterable, Hashable, Identifiable {
    case gangnam = "강남"
    case hongdae = "홍대"
    case shinchon = "신촌"
    var id: String { rawValue }
}

struct Showtime: Identifiable, Hashable {
    let id = UUID()
    let theater: Theater
    let screenName: String   // 예: "크리클라이너 1관"
    let format: String       // 예: "2D"
    let start: Date
    let end: Date
    let remaining: Int
    let capacity: Int
}
