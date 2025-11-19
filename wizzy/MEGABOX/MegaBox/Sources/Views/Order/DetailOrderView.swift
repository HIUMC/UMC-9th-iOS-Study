//
//  DetailOrderView.swift
//  MegaBox
//
//  Created by 이서현 on 11/17/25.
//

import SwiftUI

struct DetailOrderView: View {
    var body: some View {
      ScrollView {
        VStack(spacing: 0) {
          OrderNavigationBar()
            .padding(.bottom, 16)
          DetailOrderGridView()
        }
        .padding(.horizontal, 16)
      }
    }
}

#Preview {
    DetailOrderView()
}
