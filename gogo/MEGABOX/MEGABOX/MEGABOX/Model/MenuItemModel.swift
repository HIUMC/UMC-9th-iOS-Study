//
//  MenuItemModel.swift
//  MEGABOX
//
//  Created by 고석현 on 11/15/25.
//


import Foundation

struct MenuItemModel: Identifiable, Hashable {
    let id = UUID()

    let imageName: String
    let title: String
    let price: Int

    // 추가
    let isBest: Bool     // BEST 배지
    let isRecommended: Bool // 추천 배지 (추천 상품)
    let isSoldOut: Bool  // 품절 여부
}
