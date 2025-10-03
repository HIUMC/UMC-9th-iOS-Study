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
        MovieCard(MoviePoster: Image("어쩔수가없다"), MovieName: "어쩔수가없다", People: "20만", bigPoster: Image("bigF1"), subTitle: "F1: The Movie",
                  explaination:"최고가 되지 못한 전설 VS 최고가 되고 싶은 루키\n\n한때 주목받는 유망주였지만 끔찍한 사고로 F1에서  우승하지 못하고\n한순간에 추락한 드라이버 ‘손; 헤이스'(브래드 피트).\n그의 오랜 동료인 ‘루벤 세르반테스'(하비에르 바르뎀)에게\n레이싱 복귀를 제안받으며 최하위 팀인 APGXP에 합류한다." ,
                  smallPoster: Image("smallF1"), age: "12세 이상 관람가", date: "2025.06,25 개봉"),
        
        MovieCard(MoviePoster: Image("무한성"), MovieName: "극장판 귀멸의 칼날", People: "50만", bigPoster: Image("bigF1"), subTitle: "F1: The Movie",
                  explaination:"최고가 되지 못한 전설 VS 최고가 되고 싶은 루키\n\n한때 주목받는 유망주였지만 끔찍한 사고로 F1에서  우승하지 못하고\n한순간에 추락한 드라이버 ‘손; 헤이스'(브래드 피트).\n그의 오랜 동료인 ‘루벤 세르반테스'(하비에르 바르뎀)에게\n레이싱 복귀를 제안받으며 최하위 팀인 APGXP에 합류한다." ,
                  smallPoster: Image("smallF1"), age: "12세 이상 관람가", date: "2025.06,25 개봉"),
        
        MovieCard(MoviePoster: Image("F1"), MovieName: "F1 더 무비", People: "100만", bigPoster: Image("bigF1"), subTitle: "F1: The Movie",
                  explaination:"최고가 되지 못한 전설 VS 최고가 되고 싶은 루키\n\n한때 주목받는 유망주였지만 끔찍한 사고로 F1에서  우승하지 못하고\n한순간에 추락한 드라이버 ‘손; 헤이스'(브래드 피트).\n그의 오랜 동료인 ‘루벤 세르반테스'(하비에르 바르뎀)에게\n레이싱 복귀를 제안받으며 최하위 팀인 APGXP에 합류한다." ,
                  smallPoster: Image("smallF1"), age: "12세 이상 관람가", date: "2025.06,25 개봉"),
        
        MovieCard(MoviePoster: Image("얼굴"), MovieName: "얼굴", People: "40만", bigPoster: Image("bigF1"), subTitle: "F1: The Movie",
                  explaination:"최고가 되지 못한 전설 VS 최고가 되고 싶은 루키\n\n한때 주목받는 유망주였지만 끔찍한 사고로 F1에서  우승하지 못하고\n한순간에 추락한 드라이버 ‘손; 헤이스'(브래드 피트).\n그의 오랜 동료인 ‘루벤 세르반테스'(하비에르 바르뎀)에게\n레이싱 복귀를 제안받으며 최하위 팀인 APGXP에 합류한다." ,
                  smallPoster: Image("smallF1"), age: "12세 이상 관람가", date: "2025.06,25 개봉"),
        
        MovieCard(MoviePoster: Image("모노노카히메"), MovieName: "모노노카 히메", People: "5만", bigPoster: Image("bigF1"), subTitle: "F1: The Movie",
                  explaination:"최고가 되지 못한 전설 VS 최고가 되고 싶은 루키\n\n한때 주목받는 유망주였지만 끔찍한 사고로 F1에서  우승하지 못하고\n한순간에 추락한 드라이버 ‘손; 헤이스'(브래드 피트).\n그의 오랜 동료인 ‘루벤 세르반테스'(하비에르 바르뎀)에게\n레이싱 복귀를 제안받으며 최하위 팀인 APGXP에 합류한다." ,
                  smallPoster: Image("smallF1"), age: "12세 이상 관람가", date: "2025.06,25 개봉")
    ]
}
