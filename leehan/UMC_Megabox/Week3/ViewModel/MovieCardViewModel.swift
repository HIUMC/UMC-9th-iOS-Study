//
//  MovieCardViewMOdel.swift
//  UMC_Megabox
//
//  Created by 이한결 on 9/30/25.
//

import SwiftUI
import Foundation

/* 뷰에 넣어줄 더미 데이터 */
@Observable
class MovieCardViewModel {
    var movieCards = [
        MovieCard(MoviePoster: Image("어쩔수가없다"), MovieName: "어쩔수가없다", People: "20만"),
        MovieCard(MoviePoster: Image("무한성"), MovieName: "극장판 귀멸의 칼날", People: "50만"),
        MovieCard(MoviePoster: Image("F1"), MovieName: "F1 더 무비", People: "100만"),
        MovieCard(MoviePoster: Image("얼굴"), MovieName: "얼굴", People: "40만"),
        MovieCard(MoviePoster: Image("모노노카히메"), MovieName: "모노노카 히메", People: "5만")
    ]
}
