//
//  HomeViewModel.swift
//  week1_homework
//
//  Created by 정승윤 on 10/1/25.
//

import Foundation
import SwiftUI

@Observable
class MovieViewModel {
    var movies: [MovieModel] = [
        MovieModel(posterName: "noway", secPosterName: "f1Poster",name: "어쩔수가없다",engname:"No Other Choice" ,performance: "20만"),
        MovieModel(posterName: "blade",secPosterName: "f1Poster", name: "극장판 귀멸의칼날",engname:"Demon Slayer: Kimetsu no Yaiba – The Movie: Infinity Castle" ,performance: "1"),
        MovieModel(posterName: "f1",secPosterName: "f1Poster", name: "F1 더 무비",engname:"F1 The Movie" ,performance: "50"),
        MovieModel(posterName: "face", secPosterName: "f1Poster",name: "얼굴",engname:"The Ugly" ,performance: "2"),
        MovieModel(posterName: "hime",secPosterName: "f1Poster", name: "모노노케 히메 ",engname:"Princess Mononoke", performance:"3")
    ]
}
