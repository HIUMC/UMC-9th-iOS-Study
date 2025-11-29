//
//  MenuItemModel.swift
//  MegaBox
//
//  Created by 박병선 on 11/20/25.
//
import Foundation

struct MenuItemModel: Identifiable, Hashable {
    let id: UUID = UUID()
    
    let name: String          // "러브 콤보"
    let price: Int            // 10900
    let imageName: String     // "menu_popcorn_love_combo"
    
    // 섹션(추천/베스트/기타 등 구분용)
    let category: MenuCategory
}

enum MenuCategory: String {
    case recommended = "추천 메뉴"
    case best = "베스트 메뉴"
}


struct OrderMenuItemModel: Identifiable {
    let id: UUID = UUID()
    let name: String
    let price: Int
    let originalPrice: Int?
    let imageName: String
    let badgeType: MenuBadgeType?
    let isSoldOut: Bool
    let discountRate: Int?
}

enum MenuBadgeType {
    case best
    case recommended
}
