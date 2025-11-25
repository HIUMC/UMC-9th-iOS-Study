//
//  LoginViewModel.swift
//  MegaBox
//
//  Created by 이서현 on 9/21/25.
//

import Foundation

@Observable
class LoginViewModel {
    
    var loginModel: LoginModel
    
    init() {
        self.loginModel = LoginModel() ///뷰모델이 생성될 때 항상 빈 모델로 시작하게 만들고 싶을 때 
    }
    
    
}
