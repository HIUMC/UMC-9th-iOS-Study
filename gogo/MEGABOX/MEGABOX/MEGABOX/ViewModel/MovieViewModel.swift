//
//  MovieViewModel.swift
//  MEGABOX
//
//  Created by 고석현 on 10/2/25.
//

import Foundation


@Observable
class MovieViewModel {
    var movies: [MovieModel] = [
        .init(title: "어쩔 수가 없다", poster: "poster1", countAudience: "20만"),
        .init(title: "극장판 귀멸의 칼날", poster: "poster2", countAudience: "1"),
        .init(title: "F1 더 무비", poster: "poster3", countAudience: "30만")
    ]
}
