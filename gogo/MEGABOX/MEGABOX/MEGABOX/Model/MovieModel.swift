//
//  MovieModel.swift
//  MEGABOX
//
//  Created by 고석현 on 10/2/25.
//

import Foundation

import Foundation

struct MovieModel: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let poster: String
    let countAudience: String
    //F1 상세 화면용 추가 변수
    let description: String?
    let releaseDate: String?
    let rating: String?
}
