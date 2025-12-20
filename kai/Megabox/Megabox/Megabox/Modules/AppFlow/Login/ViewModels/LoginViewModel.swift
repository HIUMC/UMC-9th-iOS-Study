//
//  LoginViewModel.swift
//  Megabox
//
//  Created by 김지우 on 9/24/25.
//

import Foundation
import SwiftUI
import SafariServices // 'openKakaoLogin'에 필요

@Observable
class LoginViewModel {
    
    // LoginModel은 LoginView에서 @Bindable로 직접 사용
    var loginModel = LoginModel(id: "", pwd: "", name: "")

    // --- [Part 1] 일반 로그인 버튼 액션 ---
    @MainActor func handleStandardLogin(authManager: AuthManager) {
        // 1. 뷰에서 입력받은 값으로 AuthManager의 로그인 함수 호출
        authManager.performStandardLogin(
            name: loginModel.name,
            id: loginModel.id,
            pwd: loginModel.pwd
        )
    }
    
    // --- [Part 2] 카카오 로그인 버튼 액션 ---
    
    // 1. (웹뷰 열기) SFSafariViewController 열기
    func openKakaoLogin() {
        let urlString = "https://kauth.kakao.com/oauth/authorize?client_id=\(Config.kakaoRestApiKey)&redirect_uri=\(Config.kakaoRedirectUri)&response_type=code"
        
        guard let url = URL(string: urlString) else {
            print("LoginViewModel: Invalid Kakao Auth URL")
            return
        }
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController else {
            print("LoginViewModel: App's root view controller not found.")
            return
        }
        
        let safariViewController = SFSafariViewController(url: url)
        rootViewController.present(safariViewController, animated: true)
    }
    
    // 2. (.onOpenURL) 리다이렉트된 URL에서 코드를 추출한 뒤 이 함수 호출
    func handleKakaoLogin(authCode: String, authManager: AuthManager) {
        // ViewModel이 비동기 작업을 직접 처리
        Task {
            await authManager.performKakaoLogin(authCode: authCode)
        }
    }
    
    // .onOpenURL에서 URL을 파싱하기 위한 헬퍼 함수
    func extractAuthorizationCode(from url: URL) -> String? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
              let queryItems = components.queryItems else {
            return nil
        }
        
        return queryItems.first(where: { $0.name == "code" })?.value
    }
}
