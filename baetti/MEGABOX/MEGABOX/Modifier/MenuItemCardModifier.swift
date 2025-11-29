//
//  MenuItemCardModifier.swift
//  MEGABOX
//
//  Created by 박정환 on 11/19/25.
//

import SwiftUI

// MARK: - BEST Badge
struct BestBadge: ViewModifier {
    let isBest: Bool
    func body(content: Content) -> some View {
        ZStack(alignment: .topLeading) {
            content
            if isBest {
                Text("BEST")
                    .font(.semiBold12)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(4)
                    .padding(6)
            }
        }
    }
}

extension View {
    func bestBadge(_ value: Bool) -> some View {
        self.modifier(BestBadge(isBest: value))
    }
}

// MARK: - Recommend Badge
struct RecommendBadge: ViewModifier {
    let isRecommended: Bool
    func body(content: Content) -> some View {
        ZStack(alignment: .topLeading) {
            content
            if isRecommended {
                Text("추천")
                    .font(.semiBold12)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(4)
                    .padding(6)
            }
        }
    }
}

extension View {
    func recommendBadge(_ value: Bool) -> some View {
        self.modifier(RecommendBadge(isRecommended: value))
    }
}

// MARK: - Discount Label Modifier
struct DiscountLabel: ViewModifier {
    let originalPrice: Int?

    func body(content: Content) -> some View {
        HStack(spacing: 5) {
            content

            if let originalPrice {
                Text("\(originalPrice)원")
                    .font(.regular9)
                    .foregroundColor(.gray03)
                    .strikethrough(true, color: .gray03)
            }
        }
    }
}

extension View {
    func discountLabel(_ originalPrice: Int?) -> some View {
        self.modifier(DiscountLabel(originalPrice: originalPrice))
    }
}

// MARK: - Sold Out Overlay
struct SoldOutModifier: ViewModifier {
    let isSoldOut: Bool
    func body(content: Content) -> some View {
        ZStack {
            content
            if isSoldOut {
                Rectangle()
                    .foregroundColor(Color.black.opacity(0.55))
                Text("품절")
                    .font(.semiBold14)
                    .foregroundColor(.white)
            }
        }
    }
}

extension View {
    func soldOut(_ value: Bool) -> some View {
        self.modifier(SoldOutModifier(isSoldOut: value))
    }
}
