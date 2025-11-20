//
//  soldOut.swift
//  MEGABOX
//
//  Created by 정승윤 on 11/20/25.
//

import Foundation
import SwiftUI

struct SoldOut: View {
    var body: some View {
        Text("품절")
    }
}

struct SoldOutModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay {
                // 반투명 회색 배경
                Color.black.opacity(0.5)
                
                // 품절 텍스트
                Text("품절")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }.shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 3)
    }
}

extension View {
    // .soldOut(item.isSoldOut) 형태로 사용
    func soldOut(isSoldOut: Bool) -> some View {
        if isSoldOut {
            return AnyView(self.modifier(SoldOutModifier()))
        } else {
            return AnyView(self)
        }
    }
}
