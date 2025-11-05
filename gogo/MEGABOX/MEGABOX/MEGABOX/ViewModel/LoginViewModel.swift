//
//  LoginViewModel.swift
//  MEGABOX
//
//  Created by 고석현 on 9/26/25.
//

import Foundation


// MARK: - 로그인 뷰모델
@Observable
class LoginViewModel {
    var loginModel: LoginModel = LoginModel()
    var id: String = ""
    var password: String = ""
    var isLoginSuccess: Bool = false
    
    // 로그인 동작: 저장은 View 쪽에서 처리
    func login() {
        if id.isEmpty || password.isEmpty {
            return
        }
        KeychainService.shared.save(id, for: KeychainService.Key.userID)
        KeychainService.shared.save(password, for: KeychainService.Key.userPassword)
        isLoginSuccess = true
    }
}
