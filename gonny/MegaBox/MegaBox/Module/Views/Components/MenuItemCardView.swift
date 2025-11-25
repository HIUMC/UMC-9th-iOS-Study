//
//  MenuItemCardView.swift
//  MegaBox
//
//  Created by 박병선 on 11/20/25.
//
import SwiftUI

struct MenuItemCardView: View {
    let item: MenuItemModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // 이미지
            Image(item.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 160, height: 160)
                .clipped()
            
            // 이름
            Text(item.name)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(.black00)
                .lineLimit(2)
            
            // 가격
            Text("\(item.price.formatted())원")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.black00)
        }
        .padding(10)
        .frame(width: 140, alignment: .leading)
        .background(Color.white)
        .cornerRadius(9)
        .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 12) {
            ForEach(MenuItemSampleData.recommended) { item in
                MenuItemCardView(item: item)
            }
        }
        .padding()
        .background(Color(.systemGray6))
    }
}
