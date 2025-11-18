//
//  LoginViewModel.swift
//  MEGABOX
//
//  Created by 고석현 on 9/26/25.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser


// MARK: - 로그인 뷰모델
@Observable
class LoginViewModel {
    var loginModel: LoginModel = LoginModel()
    var id: String = ""
    var password: String = ""
    var isLoginSuccess: Bool = false
    
    // 로그인 동작: 저장은 View 쪽에서 처리 , 키체인 이용
    func login() {
        if id.isEmpty || password.isEmpty {
            return
        }
        KeychainService.shared.save(id, for: KeychainService.Key.userID)
        KeychainService.shared.save(password, for: KeychainService.Key.userPassword)
        isLoginSuccess = true
    }
}

//MARK: - 카카오 로그인 구현

extension LoginViewModel {
    /// 카카오 로그인: 카카오톡 가능 시 우선 시도, 불가능/실패 시 계정(브라우저) 로그인으로 폴백!
    /// - : 성공 여부 반환 !
    func kakaoLogin(completion: @escaping (Bool) -> Void) {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let _ = oauthToken {
                    //  Keychain 등에 토큰 저장
                    completion(true)
                } else {
                    // 카카오톡 실패하면 계정 로그인으로 재시도
                    self.loginWithKakaoAccount(completion: completion)
                }
            }
        } else {
            self.loginWithKakaoAccount(completion: completion)
        }
    }

    /// 카카오 계정로그인 , escapijng으로 비동기화 처리 !!
    fileprivate func loginWithKakaoAccount(completion: @escaping (Bool) -> Void) {
        UserApi.shared.loginWithKakaoAccount { oauthToken, error in
            if let _ = oauthToken {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
