//
//  MovieCardModel.swift
//  Megabox
//
//  Created by 김지우 on 10/2/25.
//

import Foundation

// MARK: 순수 데이터 정의
struct MovieCardModel: Identifiable, Hashable {
    let id: Int               // API에서 id를 받으므로 Identifiable을 위해 Int로 변경
    let title: String         // 영화 제목
    let posterURL: URL?       // Kingfisher가 사용할 포스터 이미지 URL
    let releaseDate: String?  // 개봉일
    let audienceCount: String // 누적 관객수 (하드코딩)
    let rating: String        // 영화 관람 등급 (하드코딩)
}


// MARK: - Route/Segment 정의
enum MovieSegment: String, CaseIterable, Hashable {
    case chart = "무비차트"
    case upcoming = "상영예정"
}
