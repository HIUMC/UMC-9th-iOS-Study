//
//  ViewModifier.swift
//  MegaBox
//
//  Created by 박병선 on 11/20/25.
//
import SwiftUI



// MARK: - BEST / 추천 뱃지

struct BadgeModifier: ViewModifier {
    let type: MenuBadgeType?
    
    func body(content: Content) -> some View {
        ZStack(alignment: .topLeading) {
            content
            
            if let type {
                let text  = (type == .best) ? "BEST" : "추천"
                let color = (type == .best)
                    ? Color(red: 1.0, green: 0.38, blue: 0.38)
                    : Color(red: 0.27, green: 0.51, blue: 0.96)
                
                Text(text)
                    .font(.system(size: 11, weight: .bold))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(color)
                    .foregroundColor(.white)
                    .cornerRadius(4)
                    .padding(8)
            }
        }
    }
}


struct SoldOutModifier: ViewModifier {
    let isSoldOut: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isSoldOut {
                Color.black.opacity(0.45)
                    .cornerRadius(16)
                
                Text("품절")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
            }
        }
    }
}

struct DiscountModifier: ViewModifier {
    let discountRate: Int?
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            
            if let rate = discountRate {
                Text("\(rate)%")
                    .font(.system(size: 11, weight: .bold))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(4)
                    .padding(8)
            }
        }
    }
}

// MARK: - View 확장
extension View {
    func bestBadge(_ isBest: Bool) -> some View {
        self.modifier(BadgeModifier(type: isBest ? .best : nil))
    }
    
    func recommendedBadge(_ isRecommended: Bool) -> some View {
        self.modifier(BadgeModifier(type: isRecommended ? .recommended : nil))
    }
    
    func soldOut(_ isSoldOut: Bool) -> some View {
        self.modifier(SoldOutModifier(isSoldOut: isSoldOut))
    }
    
    func discount(_ rate: Int?) -> some View {
        self.modifier(DiscountModifier(discountRate: rate))
    }
}
