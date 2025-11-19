//
//  OrderMainCard.swift
//  MegaBox
//
//  Created by 이서현 on 11/18/25.
//

import SwiftUI

struct OrderMainCardButton: View {
  let title: String
  let subtitle: String?
  let icon: Image
  let action: () -> Void

  var body: some View {
    Button(action: action) {
      ZStack {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .stroke(Color(.systemGray4), lineWidth: 1)
          .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
              .fill(Color.white)
          )

        VStack(alignment: .leading, spacing: 8) {
          Text(title)
            .font(.PretendardBold22)

          if let subtitle {
            Text(subtitle)
              .font(.system(size: 13))
              .foregroundColor(.gray)
          }

          Spacer()

          icon
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(16)
      }
    }
    .buttonStyle(.plain)
  }
}
