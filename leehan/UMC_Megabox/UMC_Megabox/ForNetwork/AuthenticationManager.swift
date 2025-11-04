//
//  AuthenticationManager.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/5/25.
//

import SwiftUI
import Observation

@Observable
class AuthenticationManager: ObservableObject {
    
    // 앱의 현재 로그인 상태 - false면 LoginView, true면 MainTabView
    var isLoggedIn: Bool = false
    
    init() {
        /// 앱이 시작될 때(AuthenticationManager가 생성될 때) 키체인에 토큰이 있는지 확인
        /// --> KeychainService의 loadTokenInfo함수 활용
        //checkTokenStatus()
    }
    
    private func checkTokenStatus() {
        Task { @MainActor in
            self.isLoggedIn = KeychainService.shared.loadToken()
            
            
            if self.isLoggedIn {
                print("AuthManager(Task): 토큰 있음")
            } else {
                print("AuthManager(Task): 토큰 없음")
            }
        }
    }
    
    func login(tokenInfo: TokenInfo) {
        // 로그인 성공 시 토큰 저장
        KeychainService.shared.saveToken(tokenInfo)
        self.isLoggedIn = true
    }
    
    func logout() {
        // 키체인에서 토큰 삭제
        KeychainService.shared.deleteToken()
        self.isLoggedIn = false
    }
}
