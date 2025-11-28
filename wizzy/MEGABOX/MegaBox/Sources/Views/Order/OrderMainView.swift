//
//  OrderMainView.swift
//  MegaBox
//
//  Created by 이서현 on 11/18/25.
//

import SwiftUI

struct OrderMainView: View {
  
  @Environment(NavigationRouter.self) var router
  
  var body: some View {
    ZStack {
      VStack(spacing: 16) {
        HStack(spacing: 16) {
          OrderMainCardButton(
            title: "바로 주문",
            subtitle: "이제 줄서지 말고\n모바일로 주문하고 픽업!",
            icon: Image(.popcornIcon),
            action: {
              router.path.append(Route.mobileOrder)
            }
          )
          .frame(maxWidth: .infinity)
          .frame(height: 275)

          VStack(spacing: 16) {
            OrderMainCardButton(
              title: "스토어 교환권",
              subtitle: nil,
              icon: Image(.ticketIcon),
              action: {}
            )
            .frame(maxWidth: .infinity)
            .frame(height: 130)

            OrderMainCardButton(
              title: "선물하기",
              subtitle: nil,
              icon: Image(.presentIcon),
              action: {}
            )
            .frame(maxWidth: .infinity)
            .frame(height: 130)
          }
          .frame(maxWidth: .infinity)
        }

        OrderMainCardButton(
          title: "어디서든 팝콘 만나기",
          subtitle: "팝콘 콜라 스낵 모든 메뉴 배달 가능!",
          icon: Image(.motorcycleIcon),
          action: {}
        )
        .frame(maxWidth: .infinity)
        .frame(height: 54)
        .padding(.top, 46)
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 24)
    }
  }
}
