//
//  DetailedMovieCardViewModel.swift
//  UMC_Megabox
//
//  Created by 이한결 on 9/30/25.
//

import SwiftUI
import Foundation

@Observable
class DetailedMovieCardViewModel {
    var detailedMovieCards = [
        DetailedMovieCard(subTitle: "F1: The Movie",
                          explaination:"최고가 되지 못한 전설 VS 최고가 되고 싶은 루키\n\n한때 주목받는 유망주였지만 끔찍한 사고로 F1에서  우승하지 못하고\n한순간에 추락한 드라이버 ‘손; 헤이스'(브래드 피트).\n그의 오랜 동료인 ‘루벤 세르반테스'(하비에르 바르뎀)에게\n레이싱 복귀를 제안받으며 최하위 팀인 APGXP에 합류한다." ,
                          smallPoster: Image("smallF1"), age: "12세 이상 관람가", date: "2025.06,25 개봉")
        ]
}
