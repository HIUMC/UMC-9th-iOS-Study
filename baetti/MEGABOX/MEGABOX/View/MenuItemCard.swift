//
//  MenuItemCard.swift
//  MEGABOX
//
//  Created by 박정환 on 11/19/25.
//


import SwiftUI

struct MenuItemCard: View {
    let item: MenuItemModel
    
    var body: some View {
        VStack(alignment: .leading) {
            
            ZStack(alignment: .topLeading) {
                Image(item.imageName)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
            }
            .soldOut(item.isSoldOut)
            .padding(.bottom, 12)
            
            Text(item.title)
                .font(.regular13)
                .foregroundColor(.black)
            
            Text("\(item.price)원")
                .font(.semiBold14)
                .foregroundColor(.black)
                .discountLabel(item.originalPrice)
        }
        .bestBadge(item.isBest)
        .recommendBadge(item.isRecommended)
        .frame(width: 158)
    }
}
