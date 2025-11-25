//
//  MenuViewModifier.swift
//  MegaBox
//
//  Created by 이서현 on 11/17/25.
//

import SwiftUI

struct MenuImageStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .frame(width: 152, height: 152)
      .clipShape(RoundedRectangle(cornerRadius: 10))
  }
}

struct allMenuImageStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .aspectRatio(1, contentMode: .fit)
      .frame(maxWidth: .infinity)
      .clipShape(RoundedRectangle(cornerRadius: 10))
      
  }
}


struct MenuNameStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.PretendardMedium14)
      .foregroundStyle(.black)
  }
}

struct MenuPriceStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.PretendardSemiBold14)
      .foregroundStyle(Color(.black))
  }
}

struct OrderMainTextStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.PretendardBold22)
      .foregroundStyle(.black)
  }
}

struct OrderSubTextStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.PretendardRegular12)
      .foregroundStyle(.gray06)
  }
}

struct BestBadge: ViewModifier {
  let isBest: Bool
  
  func body(content: Content) -> some View {
    content
      .overlay(alignment: .topLeading) {
        if isBest {
          Image(.badgeMenu)
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .frame(width: 51, height: 25)
        }
      }
  }
}

struct RecommandBadge: ViewModifier {
  let isRecommand: Bool
  
  func body(content: Content) -> some View {
    content
      .overlay(alignment: .topLeading) {
        if isRecommand {
          Image(.badgeRecommand)
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .frame(width: 51, height: 25)
        }
      }
  }
}

struct SoldOutBadge: ViewModifier {
  let isSoldOut: Bool
  
  func body(content: Content) -> some View {
    ZStack {
      content
      if isSoldOut {
        RoundedRectangle(cornerRadius: 10)
          .fill(Color.black.opacity(0.8))
        Text("품절")
          .font(.PretendardSemiBold14)
          .foregroundStyle(.white)
      }
    }
  }
}
