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
        .init(title: "어쩔 수가 없다", poster: "poster1", countAudience: "20만", description: nil, releaseDate: nil, rating: nil ),
        .init(title: "극장판 귀멸의 칼날", poster: "poster2", countAudience: "1", description: nil, releaseDate: nil, rating: nil),
        .init(title: "F1 더 무비", poster: "poster3", countAudience: "30만", description: "최고가 되지 못한 전설 VS 최고가 되고 싶은 루키\n\n한때 주목받는 유망주였지만 끔찍한 사고로 F1에서 우승하지 못하고\n한순간에 추락한 드라이버 ‘손; 헤이스’(브래드 피트).\n그의 오랜 동료인 ‘루벤 세르반테스’(하비에르 바르뎀)에게\n레이싱 복귀를 제안받으며 최하위 팀인 APGX에 합류한다.", releaseDate: "2025.06.25 개봉", rating: "12세 이상 관람가"),
        .init(title:"얼굴", poster:"poster4", countAudience:"50만", description: nil, releaseDate: nil, rating: nil),
        .init(title: "모노노케 히메", poster: "poster5", countAudience: "랜덤", description: nil, releaseDate: nil, rating: nil),
        .init(title: "보스", poster: "poster6", countAudience: "랜덤", description: nil, releaseDate: nil, rating: nil),
        .init(title: "야당", poster: "poster7", countAudience: "랜덤", description: nil, releaseDate: nil, rating: nil),
        .init(title: "The Roses", poster: "poster8", countAudience: "랜덤", description: nil, releaseDate: nil, rating: nil)
    ]
}
