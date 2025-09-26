//
//  LoginViewModel.swift
//  MEGABOX
//
//  Created by 고석현 on 9/26/25.
//

import Foundation
import Observation

// MARK: - 로그인 뷰모델
@Observable
class LoginViewModel {
    var loginModel: LoginModel = LoginModel()
    
    // 로그인 동작: 저장은 View 쪽에서 처리
    func login() {
        // 이 안에서는 UserDefaults나 네트워크 호출 같은 로직만 넣을 수 있음
        // AppStorage 저장은 View(LoginView)에서 수행
    }
}

