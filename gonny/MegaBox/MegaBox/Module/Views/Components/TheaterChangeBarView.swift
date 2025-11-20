//
//  TheaterChangeBarView.swift
//  MegaBox
//
//  Created by 박병선 on 11/20/25.
//
import SwiftUI

struct TheaterChangeBarView: View {
    let theaterName: String
    let onChangeTheater: () -> Void
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "mappin.and.ellipse")
                .foregroundColor(.black)
            
            Text(theaterName)
                .font(.pretendardRegular(14))
                .foregroundStyle(.black00)
            
            Spacer()
            
            Button(action: onChangeTheater) {
                Text("극장 변경")
                    .font(.pretendardSemiBold(13))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 6)
                    .foregroundStyle(Color(hex: "660ED8"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color(hex: "660ED8"), lineWidth: 1)
                    )
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(Color.white)
    }
}
