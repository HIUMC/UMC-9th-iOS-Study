//
//  OrderMenuItem.swift
//  MegaBox
//
//  Created by 박병선 on 11/20/25.
//
import SwiftUI

struct OrderMenuItemCardView: View {
    let item: OrderMenuItemModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(item.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 130)
            
            Text(item.name)
                .font(.system(size: 14))
                .foregroundColor(.black)

            HStack(spacing: 4) {
                if let original = item.originalPrice {
                    Text("\(original.formatted())원")
                        .foregroundColor(.gray)
                        .strikethrough()
                }

                Text("\(item.price.formatted())원")
                    .fontWeight(.semibold)
            }
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 4)
        .bestBadge(item.badgeType == .best)
        .recommendedBadge(item.badgeType == .recommended)
        .discount(item.discountRate)
        .soldOut(item.isSoldOut)
    }
}
