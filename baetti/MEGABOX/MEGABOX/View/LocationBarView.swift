//
//  LocationBarView.swift
//  MEGABOX
//
//  Created by 박정환 on 11/19/25.
//

import SwiftUI

struct LocationBarView: View {
    @Environment(\.theaterButtonBorderColor) private var theaterButtonBorderColor

    var body: some View {
        HStack {
            Image(systemName: "location.circle.fill")
            
            Text("강남")
                .font(.semiBold13)
                .padding(.horizontal, 10)
            
            Spacer()
            
            Button {
                print("극장 변경 tapped")
            } label: {
                Text("극장 변경")
                    .font(.semiBold13)
                    .padding(.horizontal, 9)
                    .padding(.vertical, 9)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(theaterButtonBorderColor, lineWidth: 1)
                    )
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}

#Preview {
    LocationBarView()
}
