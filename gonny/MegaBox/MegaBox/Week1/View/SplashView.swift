//
//  SplashView.swift
//  MegaBox
//
//  Created by 박병선 on 9/16/25.
//
// 1주차-스플래시뷰, 로그인뷰

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 249,height: 84)
        
        }
    }
}

#Preview{
    SplashView()
}
