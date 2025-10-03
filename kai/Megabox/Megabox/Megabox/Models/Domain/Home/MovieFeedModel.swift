//
//  MovieFeedModel.swift
//  Megabox
//
//  Created by 김지우 on 10/2/25.
//

import Foundation

struct MovieFeedModel: Identifiable, Hashable {
    let id = UUID()
    let title: String          // 9월, 메가박스의 영화들(1) - 명작들의 재개봉
    let subtitle: String?      // <모노노케 히메>, <퍼펙트 블루>
    let contentDescription: String? // 영화 속 압도적인 감정 표출 대비
    let imageAssetName: String // 피드 좌측 썸네일 이미지 이름
}
