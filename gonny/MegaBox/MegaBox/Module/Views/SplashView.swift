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


    @StateObject private var loginVM = LoginViewModel()
    
    var body: some View {
        Group {
            if isActive {
                if isLoggedIn {
                    // 로그인 돼 있으면 메인으로
                    BaseTabView()
                        .environmentObject(loginVM)
                } else {
                    // 안 돼 있으면 로그인 화면
                    LoginView()
                        .environmentObject(loginVM)
                }
            } else {
                // 스플래시 화면
                ZStack {
                    Color.white.ignoresSafeArea()
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 249, height: 84)
                }
            }
        }
        .onAppear {
            /*
            // 1) 앱 켜졌을 때 키체인에서 자동 로그인 시도
             if loginVM.loadFromKeychainIfExists() {
                // ViewModel이 키체인에서 찾았으면 로그인 상태 true로
                isLoggedIn = true
            }
             */
             

            // 2) 스플래시 잠깐 보여주고 메인으로 넘기기
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation {
                    isActive = true
                }
            }
        }
    }
}
/*
#Preview {
    SplashView()
}
*/
