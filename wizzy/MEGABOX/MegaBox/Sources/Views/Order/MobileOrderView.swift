//
//  MobileOrderView.swift
//  MegaBox
//
//  Created by 이서현 on 11/17/25.
//

import SwiftUI

struct MobileOrderView: View {
  
  var body: some View {
    ScrollView() {
      VStack(alignment: .leading) {
        OrderMainView()
          .padding(.bottom, 35)
        LabelView(menuText: "추천 메뉴", subText: "영화 볼때 뭐먹지 고민될 땐 추천 메뉴!")
        RecommendMenuScrollView()
          .padding(.bottom, 47)
        
        LabelView(menuText: "베스트 메뉴", subText: "영화 볼때 뭐먹지 고민될 땐 베스트 메뉴!")
        BestMenuScrollView()
      }
      .padding(.horizontal, 16)
    }
  }
}

struct LabelView: View {
  let menuText: String
  let subText: String
  
  var body: some View {
    VStack (alignment: .leading, spacing: 10) {
      Text(menuText)
        .modifier(OrderMainTextStyle())
      Text(subText)
        .modifier(OrderSubTextStyle())
    }
  }
}

struct RecommendMenuScrollView: View {
  let menu = MenuItemModel.allMenu
  
    var body: some View {
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: 16) {
          ForEach(menu.filter {$0.isRecommended}) { item in
            RecommandMenuButton(item: item, action: {})
          }
        }
      }
    }
}

struct BestMenuScrollView: View {
  let menu = MenuItemModel.allMenu
  
    var body: some View {
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: 16) {
          ForEach(menu.filter {$0.isBest}) { item in
            BestMenuButton(item: item, action: {})
          }
        }
      }
    }
}


#Preview {
    MobileOrderView()
    .environment(NavigationRouter())
}
