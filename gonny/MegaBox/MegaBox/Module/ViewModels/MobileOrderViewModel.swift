//
//  MobileOrderViewModel.swift
//  MegaBox
//
//  Created by 박병선 on 11/20/25.
//
import Foundation

struct MenuItemSampleData {
    static let recommended: [MenuItemModel] = [
        .init(name: "러브 콤보",
              price: 10900,
              imageName: "menu_popcorn_love_combo",
              category: .recommended),
        .init(name: "더블 콤보",
              price: 24900,
              imageName: "menu_popcorn_double_combo",
              category: .recommended),
        .init(name: "디즈니 픽사 포토 세트",
              price: 15900,
              imageName: "menu_disney_photo_set",
              category: .recommended)
    ]
    
    static let best: [MenuItemModel] = [
        .init(name: "싱글 패키지",
              price: 12900,
              imageName: "menu_single_package",
              category: .best),
        .init(name: "러브 콤보",
              price: 10900,
              imageName: "menu_popcorn_love_combo",
              category: .best),
        .init(name: "러브 콤보 패키지",
              price: 18900,
              imageName: "menu_popcorn_love_combo_package",
              category: .best)
    ]
    
    static let all: [OrderMenuItemModel] = [
           .init(
               name: "싱글 콤보",
               price: 10_900,
               originalPrice: nil,
               imageName: "menu_single_package",
               badgeType: .best,
               isSoldOut: false,
               discountRate: nil
           ),
           .init(
               name: "러브 콤보",
               price: 10_900,
               originalPrice: nil,
               imageName: "menu_love_combo",
               badgeType: .best,
               isSoldOut: false,
               discountRate: nil
           ),
           .init(
               name: "더블 콤보",
               price: 24_900,
               originalPrice: nil,
               imageName: "menu_double_combo",
               badgeType: .best,
               isSoldOut: false,
               discountRate: nil
           ),
           .init(
               name: "러브 콤보 패키지",
               price: 32_000,
               originalPrice: nil,
               imageName: "menu_love_combo_package",
               badgeType: nil,
               isSoldOut: false,
               discountRate: nil
           ),
           .init(
               name: "패밀리 콤보 패키지",
               price: 47_000,
               originalPrice: nil,
               imageName: "menu_family_combo_package",
               badgeType: nil,
               isSoldOut: false,
               discountRate: nil
           ),
           .init(
               name: "메가박스 오리지널 티켓북 시즌4 톨비...",
               price: 10_900,
               originalPrice: nil,
               imageName: "menu_ticketbook",
               badgeType: .recommended,
               isSoldOut: false,
               discountRate: nil
           ),
           .init(
               name: "디즈니 픽사 포스터",
               price: 15_900,
               originalPrice: nil,
               imageName: "menu_disney_poster",
               badgeType: nil,
               isSoldOut: true,
               discountRate: nil
           ),
           .init(
               name: "인사이드아웃2 감정",
               price: 29_900,
               originalPrice: 35_900,
               imageName: "menu_insideout2",
               badgeType: nil,
               isSoldOut: false,
               discountRate: 20
           )
       ]
}
