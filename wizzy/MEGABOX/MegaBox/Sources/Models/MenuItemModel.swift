//
//  MenuItemModel.swift
//  MegaBox
//
//  Created by 이서현 on 11/17/25.
//

import SwiftUI

struct MenuItemModel: Identifiable {
  let id = UUID()
  let menuImage: Image
  let menuName: String
  let menuPrice: String
  
  let isBest: Bool
  let isRecommended: Bool
  let discountRate: Int?
  let isSoldOut: Bool
  
  init(
    menuImage: Image,
    menuName: String,
    menuPrice: String,
    isBest: Bool = false,
    isRecommended: Bool = false,
    discountRate: Int? = nil,
    isSoldOut: Bool = false
  ) {
    self.menuImage = menuImage
    self.menuName = menuName
    self.menuPrice = menuPrice
    self.isBest = isBest
    self.isRecommended = isRecommended
    self.discountRate = discountRate
    self.isSoldOut = isSoldOut
  }
  
  static let allMenu: [MenuItemModel] = [
    MenuItemModel(
      menuImage: Image(.menuBest1),
      menuName: "싱글 콤보",
      menuPrice: "10,900원",
      isBest: true,
      isRecommended: false,
      discountRate: nil,
      isSoldOut: false
    ),
    MenuItemModel(
      menuImage: Image(.menuImage1),
      menuName: "러브 콤보",
      menuPrice: "10,900원",
      isBest: false,
      isRecommended: true,
      discountRate: nil,
      isSoldOut: false
    ),
    MenuItemModel(
      menuImage: Image(.menuImage2),
      menuName: "더블 콤보",
      menuPrice: "24,900원",
      isBest: true,
      isRecommended: true,
      discountRate: nil,
      isSoldOut: false
    ),
    MenuItemModel(
      menuImage: Image(.menuImage3),
      menuName: "디즈니 픽사 포스터",
      menuPrice: "15,900원",
      isBest: false,
      isRecommended: true,
      discountRate: nil,
      isSoldOut: true
    ),
    MenuItemModel(
      menuImage: Image(.menuBest2),
      menuName: "러브 콤보 패키지",
      menuPrice: "32,000원",
      isBest: true,
      isRecommended: false,
      discountRate: nil,
      isSoldOut: false
    ),
    MenuItemModel(
      menuImage: Image(.menuBest1),
      menuName: "패밀리 콤보 패키지",
      menuPrice: "47,000원",
      isBest: false,
      isRecommended: false,
      discountRate: nil,
      isSoldOut: false
    ),
    MenuItemModel(
      menuImage: Image(.menuTicketBook),
      menuName: "메가박스 오리지널 티켓북 시즌4 돌비시네마 에디션 단품",
      menuPrice: "10,900원",
      isBest: false,
      isRecommended: true,
      discountRate: nil,
      isSoldOut: false
      ),
    MenuItemModel(
      menuImage: Image(.menuInsideOut),
      menuName: "인사이드아웃2 감정",
      menuPrice: "29,900원",
      isBest: false,
      isRecommended: true,
      discountRate: 20,
      isSoldOut: false
      )
    
  ]
}
