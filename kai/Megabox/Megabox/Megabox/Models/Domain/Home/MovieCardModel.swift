//
//  MovieCardModel.swift
//  Megabox
//
//  Created by 김지우 on 10/2/25.
//

import Foundation

// MARK: - 1. Model: 순수 데이터 정의
struct MovieCardModel: Identifiable, Hashable {
    // 고유 식별자 (Hashable 및 Identifiable 요구사항 충족)
    let id = UUID()
    
    let title: String
    let imageAssetName: String // 에셋 목록 기반의 포스터 이미지 이름
    let releaseDate: String? // 개봉일
    let audienceCount: String // 누적 관객수
}

// MARK: - Route/Segment 정의
enum MovieSegment: String, CaseIterable, Hashable {
    case chart = "무비차트"
    case upcoming = "상영예정"
}
