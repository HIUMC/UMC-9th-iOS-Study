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
      HStack {
        Image(.meboxHeader)
          .resizable()
          .scaledToFit()
          .frame(width: 149)
        Spacer()
      }
      .padding(.leading, 16)
      VStack(alignment: .leading) {
        SelectTheaterBar(style: .purple, theaterName: "강남")
          .padding(.horizontal, -16)
        OrderMainView()
          .padding(.bottom, 35)
        LabelView(menuText: "추천 메뉴", subText: "영화 볼때 뭐먹지 고민될 땐 추천 메뉴!")
        RecommendMenuScrollView()
          .padding(.bottom, 47)
        
        LabelView(menuText: "베스트 메뉴", subText: "영화 볼때 뭐먹지 고민될 땐 베스트 메뉴!")
        BestMenuScrollView()
      }
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
    .padding(.leading, 16)
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
        .padding(.leading, 16)
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
        .padding(.leading, 16)
      }
    }
}


#Preview {
    MobileOrderView()
    .environment(NavigationRouter())
}
