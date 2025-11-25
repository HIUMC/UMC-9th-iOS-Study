//
//  MobileOrderDetailViewModel.swift
//  MEGABOX
//
//  Created by 박정환 on 11/19/25.
//

import SwiftUI

class MobileOrderDetailViewModel: ObservableObject {
    @Published var items: [MenuItemModel] = []

    init() {
        loadMockData()
    }

    func loadMockData() {
        items = [
            MenuItemModel(title: "싱글 콤보", price: 10900, imageName: "single_package", isBest: true),
            MenuItemModel(title: "러브 콤보", price: 10900, imageName: "love_combo", isBest: true),
            MenuItemModel(title: "더블 콤보", price: 24900, imageName: "double_combo", isBest: true),
            MenuItemModel(title: "러브 콤보 패키지", price: 32000, imageName: "love_combo_package"),
            MenuItemModel(title: "패밀리 콤보", price: 47000, imageName: "family_combo"),
            MenuItemModel(title: "티켓북 시즌4", price: 10900, imageName: "ticketbook", isRecommended: true),
            MenuItemModel(title: "디즈니 포스터", price: 15900, imageName: "pixar_popcorn", isSoldOut: true),
            MenuItemModel(title: "인사이드아웃2 감정", price: 29900, imageName: "insideout2", originalPrice: 35000)
        ]
    }
}
