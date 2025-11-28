//
//  RecommandMenuButton.swift
//  MegaBox
//
//  Created by 이서현 on 11/17/25.
//

import SwiftUI

struct RecommandMenuButton: View {
  
  let item: MenuItemModel
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      VStack(alignment: .leading, spacing: 0) {
        item.menuImage
          .resizable()
          .modifier(MenuImageStyle())
          .padding(.bottom, 12)

        Text(item.menuName)
          .modifier(MenuNameStyle())

        Text(item.menuPrice)
          .modifier(MenuPriceStyle())
      }
      .frame(width: 152)
    }
  }
}
