//
//  MovieDetailModel.swift
//  MegaBox
//
//  Created by 이서현 on 11/8/25.
//

import Foundation

struct MovieDetailModel: Identifiable, Hashable {
    let id: Int
    let title: String
    let originalTitle: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String
}
