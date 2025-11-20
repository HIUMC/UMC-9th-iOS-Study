//
//  MenuCard.swift
//  MEGABOX
//
//  Created by 정승윤 on 11/20/25.
//

import Foundation
import SwiftUI

struct MenuCard: View {
        let menu: MenuItemModel
        
    var body: some View {
        VStack(alignment: .leading){
            Image(menu.menuImage)
                .resizable()
                .scaledToFit()
                .frame(width:152,height: 152)
                .background(.gray01)
                                .bestBadge(isEnabled: menu.isBest)       // 2) BEST 뱃지 적용
                                .recommendedBadge(isEnabled: menu.isRecommended) // 3) 추천 뱃지 적용
                                .soldOut(isSoldOut: menu.isSoldOut)      // 4) 품절 오버레이 적용
                                .clipShape(RoundedRectangle(cornerRadius: 10))
            Spacer().frame(height:12)
            Text(menu.name).font(.Pretendardmedium14).foregroundStyle(.black)
                .lineLimit(1)
            Text("\(menu.price)원").font(.PretendardsemiBold14).foregroundStyle(.black).discount(image: menu.menuImage,original: menu.price, discounted: menu.discount)
        }
    }
}


#Preview {
    // 🚨 오류 해결: MenuItemModel을 초기화하고 더미 데이터를 제공합니다.
    let dummyMenu = MenuItemModel(
        menuImage: "coublecombo",
        name: "오리지널 팝콘 (L) + 콜라",
        price: 15000,
        isBest: true,
        isRecommended: false,
        discount: 1000,
        isSoldOut: false
    )
    
    let soldOutMenu = MenuItemModel(
        menuImage: "coublecombo",
        name: "품절된 츄러스 세트",
        price: 8500,
        isBest: false,
        isRecommended: true,
        discount: nil,
        isSoldOut: true
    )
    
    HStack(spacing: 20) {
        MenuCard(menu: dummyMenu)
        MenuCard(menu: soldOutMenu)
    }
    .padding()
}
