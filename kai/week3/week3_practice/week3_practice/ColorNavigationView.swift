//
//  ColorNavigationView.swift
//  week3_practice
//
//  Created by 김지우 on 10/2/25.
//

import SwiftUI
import Observation

struct ColorNavigationView: View {
    
    @Bindable var viewModel: RainbowViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 70) {
            if let selectedRainbowModel = viewModel.selectedRainbowModel {
                Text("현재 선택된 색상 \n\(selectedRainbowModel.returnColorName())")
                    .font(.title)
                    .foregroundStyle(Color.black)
                
                Button(action: {
                    viewModel.appleLogoColor = selectedRainbowModel.returnColor()
                    dismiss()
                }, label: {
                    Text("사과 색 바꾸기")
                        .padding(.vertical, 43)
                        .padding(.horizontal, 36)
                        .overlay(content: {
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.clear)
                                .stroke(Color.black, style: .init(lineWidth: 1))
                        })
                })
            }
        }
        .navigationTitle("색 네비")
    }
}

