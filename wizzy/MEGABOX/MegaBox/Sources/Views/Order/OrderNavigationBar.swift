//
//  OrderNavigationBar.swift
//  MegaBox
//
//  Created by 이서현 on 11/17/25.
//

import SwiftUI

struct OrderNavigationBar: View {
  
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    HStack(spacing: 0) {
      Button(action: {dismiss()}) {
        Image(systemName: "chevron.left")
          .resizable()
          .frame(width: 15, height: 20)
          .tint(Color(.black))
      }
      Spacer()
      Text("바로주문")
        .font(.PretendardSemiBold18)
        .foregroundStyle(.black)
      Spacer()
      Image(.cartIcon)
        .resizable()
        .frame(width: 35, height: 35)
    }
  }
}

#Preview {
    OrderNavigationBar()
}
