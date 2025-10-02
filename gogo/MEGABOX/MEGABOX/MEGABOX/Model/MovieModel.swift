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
}
