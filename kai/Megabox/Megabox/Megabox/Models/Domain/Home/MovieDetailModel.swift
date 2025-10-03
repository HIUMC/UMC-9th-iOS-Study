//
//  MovieDetailModel.swift
//  Megabox
//
//  Created by 김지우 on 10/2/25.
//

import Foundation
import SwiftUI
import Observation

// MARK: - Model: 순수 데이터 및 상세 정보
struct MovieDetailModel: Identifiable, Hashable {
    let id = UUID()
    let titleKR: String      // F1 더 무비 (한글)
    let titleEN: String      // F1: The Movie (영어)
    let homePosterAssetName: String    // 홈 화면에서 사용되는 포스터 에셋 이름 (예: 정사각형)
    let detailPosterAssetName: String  // 상세 페이지에서 사용되는 포스터 에셋 이름 (예: 직사각형)
    
    let summary: String = "최고가 되기 못한 전설 VS 최고가 되고 싶은 루키\n\n현재 주목받는 유망주였던 솜은 F1에서 우승하지 못하고\n한순간에 추락한 드라이버 (숀 비커(브래드 피트), 그의 오랜 동료인 (맷 보몬드(하비에르 바르뎀)에게 레이싱 복귀를 제안받으며 차기 라이벌인 에이펙스에 합류한다."
    
    let rating: String = "12세 이상 관람가"
    let releaseDate: String = "2025.06.25 개봉"
}

// 탭 정의
enum MovieDetailSegment: String, CaseIterable, Hashable {
    case detail = "상세 정보"
    case review = "실관람평"
}
