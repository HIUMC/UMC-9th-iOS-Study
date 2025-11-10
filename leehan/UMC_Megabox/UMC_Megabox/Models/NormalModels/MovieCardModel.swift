//
//  MovieCardModel.swift
//  UMC_Megabox
//
//  Created by 이한결 on 9/30/25.
//

import SwiftUI
import Foundation

/* 무비 카드 가로스크롤 모델 */
struct MovieCard: Identifiable, Hashable {
    var id = UUID() // Identifiable 사용 위해선 UUID 값이 "소문자 id" 에 저장되어야 함
    var MoviePoster: String // 영화 포스터
    var MovieName: String // 영화 이름
    var People: String // 누적 관객수
    
    /* 포스터 클릭 시 상세화면 */
    var bigPoster: String
    var subTitle: String
    var explaination: String
    var smallPoster: String
    var age: String
    var date: String
}
