//
//  bestBadge.swift
//  MEGABOX
//
//  Created by 정승윤 on 11/20/25.
//

import Foundation
import SwiftUI

struct Badge: View {
    var body: some View {
        Text("Hello, World!")
    }
}
struct BadgeModifier: ViewModifier {
    let text: String
    let backgroundColor: Color

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .topLeading) {
                Text(text)
                    .font(.caption2) // 작은 글꼴
                    .foregroundStyle(.white)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(backgroundColor)
            }
    }
}

extension View {
    // .bestBadge(true) 또는 .bestBadge(false) 형태로 사용
    func bestBadge(isEnabled: Bool) -> some View {
        if isEnabled {
            return AnyView(self.modifier(BadgeModifier(text: "BEST", backgroundColor: .red)))
        } else {
            return AnyView(self)
        }
    }
    
    // .recommendedBadge(true) 형태로 사용
    func recommendedBadge(isEnabled: Bool) -> some View {
        if isEnabled {
            return AnyView(self.modifier(BadgeModifier(text: "추천", backgroundColor: .blue)))
        } else {
            return AnyView(self)
        }
    }
}
