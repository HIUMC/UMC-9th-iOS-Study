//
//  DetailOrderGridView.swift
//  MegaBox
//
//  Created by 이서현 on 11/17/25.
//

import SwiftUI


struct DetailOrderGridView: View {
  
  let menuItems = MenuItemModel.allMenu
  
  private let columns: [GridItem] = [
    GridItem(.flexible(), spacing: 16),
    GridItem(.flexible(), spacing: 16)
  ]
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns, spacing: 15) {
        ForEach(menuItems) { item in
          MenuCardView(item: item)
        }
      }
      .padding(.vertical, 24)
    }
  }
}

#Preview {
  DetailOrderGridView()
}
