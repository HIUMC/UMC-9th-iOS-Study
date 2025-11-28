//
//  TheaterTopBar.swift
//  MEGABOX
//
//  Created by 정승윤 on 11/19/25.
//

import Foundation
import SwiftUI

struct TheaterTopBar: View {
    @State private var isDetailStyle: Bool = false
    let theaterName: String
    let onTapChange: () -> Void
    
    init(theaterName: String, onTapChange: @escaping () -> Void) {
            self.theaterName = theaterName
            self.onTapChange = onTapChange
    }
    
    var body: some View {
        HStack{
            Image(.pin).resizable()
                .renderingMode(.template)
                .frame(width:27,height:27)
            Text(theaterName).font(.PretendardsemiBold13)
            Spacer()
            Button(action: {isDetailStyle.toggle()}){
                Text("극장 변경")
                    .font(.PretendardsemiBold13)
                    .buttonStateStyle(isDetail: isDetailStyle)
            }
            
        }.frame(height:56)
            .padding(.horizontal,20)
            .theaterTopBarStyle(isDetailStyle: isDetailStyle)
    }
}

struct TheaterTopBarStyle: ViewModifier {
    var isDetail: Bool

    func body(content: Content) -> some View {
        content
            .foregroundStyle(isDetail ? .white : .black) // 텍스트 색상
            .tint(isDetail ? .white : .black)            // 아이콘 색상
            .background(isDetail ? Color.purple03 : Color.white) // 전체 배경
    }
}

extension View {
    func theaterTopBarStyle(isDetailStyle: Bool) -> some View {
        self.modifier(TheaterTopBarStyle(isDetail: isDetailStyle))
    }
}

struct ButtonStateStyle: ViewModifier {
    var isDetail: Bool

    func body(content: Content) -> some View {
        content
            // 텍스트 색상: isDetail이 true일 때 흰색, false일 때 보라색
            // (요청: 텍스트는 흰색 ↔ 보라색)
            .foregroundStyle(isDetail ? .white : Color.purple03)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(isDetail ? .white : .black, lineWidth: 1).frame(width:65, height:36)
            )
    }
}


extension View {
    func buttonStateStyle(isDetail: Bool) -> some View {
        self.modifier(ButtonStateStyle(isDetail: isDetail))
    }
}

#Preview {
    TheaterTopBar(theaterName: "강남", onTapChange: {})
}

