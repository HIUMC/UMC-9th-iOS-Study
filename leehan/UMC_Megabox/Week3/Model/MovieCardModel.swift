//
//  MovieCardModel.swift
//  UMC_Megabox
//
//  Created by 이한결 on 9/30/25.
//

import SwiftUI
import Foundation

struct MovieCard: Identifiable {
    var id = UUID() // Identifiable 사용 위해선 UUID 값이 "소문자 id" 에 저장되어야 함
    var MoviePoster: Image
    var MovieName: String
    var People: String
    
    var bigPoster: Image
    var subTitle: String
    var explaination: String
    var smallPoster: Image
    var age: String
    var date: String
}
