//
//  UMC_MegaboxApp.swift
//  UMC_Megabox
//
//  Created by OOng E on 9/16/25.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct UMC_MegaboxApp: App {
    
    init() {
        let nativeAppKey = Config.nativeAppKey
        KakaoSDK.initSDK(appKey: nativeAppKey) // SDK 초기화
    }
    
    var body: some Scene {
        
        // 인증 관리자 인스턴스
        @State var authManager = AuthenticationManager()
        @State var loginViewModel = LoginViewModel()
        
        
        
        WindowGroup {
            Group {
                
                // 로그인 상태에 따라 보여주는 뷰를 결정
                if authManager.isLoggedIn {
                    // 로그인이 되었다면 MainTabView를 보여줌
                    MainTabView()
                        .environment(authManager)
                } else {
                    // 로그인이 안 되었다면 LoginView를 보여줌
                    LoginView()
                        .environment(authManager)
                        .environment(loginViewModel)
                }
            
            // URL 감지
            }.onOpenURL { url in // url에 URL이 통째로 들어옴
                if (AuthApi.isKakaoTalkLoginUrl(url)) { // 카카오 로그인 url이 맞는지 확인
                        _ = AuthController.handleOpenUrl(url: url) // SDK에 URL을 넣어줌
                }
            }
        }
    }
}
