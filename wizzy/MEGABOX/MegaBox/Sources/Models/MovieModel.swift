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
    let countAudience: String
}
