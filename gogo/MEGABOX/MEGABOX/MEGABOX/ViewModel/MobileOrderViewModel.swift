//
//  MobileOrderViewMOdel.swift
//  MEGABOX
//
//  Created by 고석현 on 11/15/25.
//

import Foundation



import Foundation
import Observation

@Observable
final class MobileOrderViewModel {

    // MARK: - 추천 메뉴
    let recommendedMenus: [MenuItemModel] = [
        MenuItemModel(imageName: "recommend1", title: "러버 콤보", price: 10900),
        MenuItemModel(imageName: "recommend2", title: "더블 콤보", price: 24900),
        MenuItemModel(imageName: "recommend3", title: "다크나이트 패키지", price: 15000)
    ]

    // MARK: - 베스트 메뉴
    let bestMenus: [MenuItemModel] = [
        MenuItemModel(imageName: "best1", title: "싱글 팝콘", price: 6900),
        MenuItemModel(imageName: "best2", title: "오리지널 팝콘", price: 5900),
        MenuItemModel(imageName: "best3", title: "카라멜 팝콘", price: 6900),
        MenuItemModel(imageName: "best4", title: "메가 콤보", price: 12000)
    ]
}
