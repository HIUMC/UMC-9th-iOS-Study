//
//  OrderViewModel.swift
//  Megabox
//
//  Created by 김지우 on 11/20/25.
//

import Foundation


// ObservableObject를 채택하여 View에서 관찰할 수 있도록 합니다.
class OrderViewModel: ObservableObject {
    
    // @Published 프로퍼티 => 데이터가 변경될 때마다 View가 자동으로 업데이트되도록 함
    @Published var recommendedMenus: [MenuItemModel] = []
    @Published var bestMenus: [MenuItemModel] = []
    
    // 현재 극장 정보
    @Published var currentCinema: String = "강남"
    
    init() {
        loadMenuData()
    }
    
    private func loadMenuData() {
        recommendedMenus = [
            MenuItemModel(menuImage: "loveCombo", menuName: "러브 콤보", menuPrice: "10,900원"),
            MenuItemModel(menuImage: "doubleCombo", menuName: "더블 콤보", menuPrice: "24,900원"),
            MenuItemModel(menuImage: "disney_poster", menuName: "디즈니 픽사 포스터", menuPrice: "15,900원")
        ]
        
        
        bestMenus = [
            MenuItemModel(menuImage: "singlePack", menuName: "싱글 패키지", menuPrice: "00,000원"),
            MenuItemModel(menuImage: "loveCombo", menuName: "러브 콤보", menuPrice: "00,000원"),
            MenuItemModel(menuImage: "lovePack", menuName: "러브 콤보 패키지", menuPrice: "00,000원")
            
        ]
    }
    
    
    func changeCinema() {
        
        // 실제 극장 변경 로직 구현
    }
}
