//
//  MenuItemModel.swift
//  MEGABOX
//
//  Created by 정승윤 on 11/18/25.
//

struct MenuItemModel: Identifiable {
    let id = UUID()
    let menuImage: String
    let name: String
    let price: Int
    
    let isBest: Bool
    let isRecommended: Bool
    let discount: Int?
    let isSoldOut: Bool
}

import Foundation
