//
//  MenuCardView.swift
//  MegaBox
//
//  Created by 이서현 on 11/17/25.
//

import SwiftUI

struct MenuCardView: View {
  let item: MenuItemModel
  
  var body: some View {
    Button(action: {}) {
      VStack(alignment: .leading, spacing: 0) {
        item.menuImage
          .resizable()
          .modifier(allMenuImageStyle())
          .modifier(RecommandBadge(isRecommand: item.isRecommended))
          .modifier(BestBadge(isBest: item.isBest))
          .modifier(SoldOutBadge(isSoldOut: item.isSoldOut))
          .padding(.bottom, 12)

        Text(item.menuName)
          .modifier(MenuNameStyle())

        Text(item.menuPrice)
          .modifier(MenuPriceStyle())
      }
    }
  }
}
