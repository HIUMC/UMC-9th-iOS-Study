//
//  MobileOrderViewModel.swift
//  MEGABOX
//
//  Created by 박정환 on 11/19/25.
//

import Foundation
import Observation

@Observable
class MobileOrderViewModel {
    
    // 추천 메뉴
    var recommendedMenu: [MenuItemModel] = []
    
    // 베스트 메뉴
    var bestMenu: [MenuItemModel] = []
    
    init() {
        loadMockData()
    }
}

extension MobileOrderViewModel {
    /// 임시 Mock 데이터 로딩
    func loadMockData() {
        recommendedMenu = [
            MenuItemModel(title: "러브 콤보", price: 10900, imageName: "love_combo"),
            MenuItemModel(title: "더블 콤보", price: 24900, imageName: "double_combo"),
            MenuItemModel(title: "디즈니 픽사 팝콘통", price: 15900, imageName: "pixar_popcorn")
        ]
        
        bestMenu = [
            MenuItemModel(title: "싱글 패키지", price: 10900, imageName: "single_package"),
            MenuItemModel(title: "더블 콤보", price: 24900, imageName: "double_combo"),
            MenuItemModel(title: "러브 콤보 패키지", price: 32000, imageName: "love_combo_package")
        ]
    }
}
