//
//  TopTheaterBarView.swift
//  MegaBox
//
//  Created by 박병선 on 11/20/25.
//
import SwiftUI

struct TopTheaterBarView: View {
    let theaterName: String
    let onChangeTheater: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "location.circle.fill")
                    .resizable()
                    .frame(width: 16, height:16)
                    .foregroundStyle(.white00)
                // 지점명
                Text(theaterName)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    onChangeTheater()
                }) {
                    Text("극장 변경")
                        .font(.pretendardSemiBold(13))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .foregroundStyle(.white00)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white, lineWidth: 1)
                        )
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
        }
        .background(Color(hex: "660ED8"))
    }
}

#Preview {
    TopTheaterBarView(theaterName: "강남", onChangeTheater: {})//프리뷰에서는 실제 클로저를 넘겨줘야됨
}
