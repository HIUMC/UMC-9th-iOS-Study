//
//  SplashView.swift
//  MegaBox
//
//  Created by 박병선 on 9/16/25.
//
// 1주차-스플래시뷰, 로그인뷰

import SwiftUI

struct SplashView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            if isLoggedIn {
                BaseTabView()
            } else {
                LoginView()
            }
        } else {
            ZStack {
                Color.white.ignoresSafeArea()
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 249,height: 84)
                
            }
        }
    }
}


#Preview{
    SplashView()
}
