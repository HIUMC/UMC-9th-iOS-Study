//
//  HomeViewModel.swift
//  week1_homework
//
//  Created by 정승윤 on 10/1/25.
//

import Foundation
import SwiftUI
import Combine

// @Observable 쓰면 Published를 못씀
@Observable
class MovieViewModel: ObservableObject {
    var movies: [MovieModel] = [
        MovieModel(posterName: "noway", secPosterName: "f1Poster",name: "어쩔수가없다",engname:"No Other Choice" ,performance: "20만", age: "15"),
        MovieModel(posterName: "blade",secPosterName: "f1Poster", name: "귀멸의 칼날: 무한성",engname:"Demon Slayer: Kimetsu no Yaiba – The Movie: Infinity Castle" ,performance: "1", age: "15"),
        MovieModel(posterName: "f1",secPosterName: "f1Poster", name: "F1 더 무비",engname:"F1 The Movie" ,performance: "50", age: "12"),
        MovieModel(posterName: "face", secPosterName: "f1Poster",name: "얼굴",engname:"The Ugly" ,performance: "2", age:"15"),
        MovieModel(posterName: "hime",secPosterName: "f1Poster", name: "모노노케 히메 ",engname:"Princess Mononoke", performance:"3", age:"ALL"),
        MovieModel(posterName: "yadang",secPosterName: "f1Poster", name: "야당 ",engname:"YADANG: The Snitch", performance:"3", age:"19"),
        MovieModel(posterName: "roses",secPosterName: "f1Poster", name: "더 로즈: 완벽한 이혼 ",engname:"The Roses", performance:"3", age:"15"),
        MovieModel(posterName: "boss",secPosterName: "f1Poster", name: "보스 ",engname:"Boss", performance:"3", age:"15")
    ]
}
