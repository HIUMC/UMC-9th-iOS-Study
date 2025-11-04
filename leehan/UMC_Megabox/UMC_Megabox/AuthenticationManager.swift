//
//  AuthenticationManager.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/5/25.
//

import SwiftUI
import Foundation

@Observable
class AuthenticationManager {
    // 앱 전역에서 로그인 상태를 공유
    var isAuthenticated: Bool = false
    
    func login() {
        // 실제로는 서버와 통신 후 성공 시 isAuthenticatd를 true로 변경
        isAuthenticated = true
    }
    
    func logout() {
        isAuthenticated = false
    }
}
