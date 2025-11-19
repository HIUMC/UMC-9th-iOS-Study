//
//  SelectTheaterComponent.swift
//  UMC_Megabox
//
//  Created by 이한결 on 11/15/25.
//

import SwiftUI

struct SelectTheaterComponent: View {
    // 어느 지역의 극장인지 저장하는 변수
    let area: String
    var backgroundcolor: Color = .purple03
    
    var body: some View {
        
        let isbackgroundWhite = (backgroundcolor == .purple03)
        
        VStack(spacing: 17) {
            
            HStack {
                Spacer().frame(width: 20)
                Image(systemName: "location.circle.fill")
                    .foregroundStyle(isbackgroundWhite ? .white : .black)
                Spacer().frame(width: 10)
                Text(area)
                    .font(.PretendardSemiBold(size: 15))
                    .foregroundStyle(isbackgroundWhite ? .white : .black)
                Spacer().frame(width: 250)
                Button( action: { } ) {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(isbackgroundWhite ? .white : .black, lineWidth: 1)
                        .frame(width: 65, height: 36)
                        .foregroundStyle(Color.clear)
                        .overlay( Text("극장 변경")
                            .font(.PretendardSemiBold(size: 13))
                            .foregroundStyle(isbackgroundWhite ? .white : .black))
                }
                Spacer().frame(width: 20)
            }.frame(width: 440, height: 56)
                .background(backgroundcolor)
        }
    }
}

#Preview {
    SelectTheaterComponent(area: "강남")
}
