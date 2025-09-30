//
//  DetailedMovieCard.swift
//  UMC_Megabox
//
//  Created by 이한결 on 9/30/25.
//

import SwiftUI
import Foundation

struct DetailedMovieCard: Identifiable {
    var id = UUID()
    var poster: Image
    var title: String
    var subTitle: String
    var explaination: String
    var smallPoster: Image
    var age: String
    var date: String
}
