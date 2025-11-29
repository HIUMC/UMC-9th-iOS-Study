//
//  MenuItemModel.swift
//  MEGABOX
//
//  Created by 박정환 on 11/19/25.
//

import Foundation

struct MenuItemModel: Identifiable {
    let id = UUID()
    let title: String
    let price: Int
    let imageName: String

    // MARK: - Card States
    var isBest: Bool = false
    var isRecommended: Bool = false
    var originalPrice: Int? = nil
    var isSoldOut: Bool = false
}
