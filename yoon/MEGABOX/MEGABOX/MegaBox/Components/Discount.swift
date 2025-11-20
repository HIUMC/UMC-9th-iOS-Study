//
//  discount.swift
//  MEGABOX
//
//  Created by 정승윤 on 11/20/25.
//

import Foundation
import SwiftUI

struct Discount: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct DiscountModifier: ViewModifier {
    let menuImage: String
    let originalPrice: Int
    let discountedPrice: Int
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading){
            HStack(spacing: 5) {
                Text("\(originalPrice-discountedPrice)원")
                    .font(.Pretendardmedium14)
                Text("\(originalPrice)원")
                    .font(.caption) // 작은 텍스트
                    .foregroundStyle(.gray02)
                    .strikethrough(true, color: .gray02)
            }
        }
    }
}

extension View {
    // .discountRate(item.discountRate) 형태로 사용 (nil 가능)
    func discount(image: String, original: Int, discounted: Int?) -> some View {
        if let discounted = discounted, discounted > 0, discounted < original {
            return AnyView(self.modifier(DiscountModifier(menuImage: image,originalPrice: original, discountedPrice: discounted)))
        } else {
            return AnyView(self)
        }
    }
}
