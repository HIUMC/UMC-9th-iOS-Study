//
//  MoveiCardModel.swift
//  MEGABOX
//
//  Created by 정승윤 on 11/12/25.
//

import Foundation

struct MovieCardModel: Identifiable, Equatable, Hashable{
    let id: Int
    let title: String
    let posterURL: String
    let originalTitle: String
    let backdropURL: String
    let overview: String
    let releaseDate: String
    let rating: String
    let attendance: String
}
