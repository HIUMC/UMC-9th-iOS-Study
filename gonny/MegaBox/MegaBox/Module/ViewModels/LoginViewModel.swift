//
//  LoginViewModel.swift
//  MegaBox
//
//  Created by 박병선 on 9/23/25.
//
import Foundation
import Security
import Observation
import SwiftUI


class LoginViewModel: ObservableObject {
    var loginModel: LoginModel = LoginModel()
    
    private let keychain = KeychainService.shared
    private let service = "com.umc.MegaBox"
    

    //로그인상태 Appstorage에 저장
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @Published var userId: String = ""
    @Published var password: String = ""
    @Published var userName: String = "" // 마이페이지 표시용
   /*
    /// 로그인 성공 시 호출
    func saveToKeychain() {
        // 아이디 저장 (이건 account로 쓰고)
        // 비밀번호는 "아이디"를 account로 해서 저장
        keychain.savePasswordToKeychain(
            account: loginModel.id,
            service: service,
            password: loginModel.pwd
        )

        // 마이페이지에서 이름처럼 쓰고 싶으면 이런 식으로 따로 하나 저장해도 돼
        keychain.savePasswordToKeychain(
            account: "user_name",
            service: service,
            password: loginModel.id
        )
    }

    /// 앱 켤 때 자동로그인 시도할 때 호출
    func loadFromKeychainIfExists() -> Bool {
        // 이름(또는 아이디)부터 가져와보고
        if let savedId = keychain.load(account: "user_name", service: service),
           let savedPw = keychain.load(account: savedId, service: service) {

            // 뷰에서 보여줄 수 있게 세팅
            self.loginModel.id = savedId
            self.loginModel.pwd = savedPw
            return true
        }
        return false
    }
    
    // 로그인 버튼 클릭 시 실행
       func login() {
           /// 실제 서버 인증 대신 단순 검증 예시
           guard !userId.isEmpty, !password.isEmpty else { return }
           
           ///Keychain에 등록
           keychain.savePasswordToKeychain(account: userId, service: service, password: password)
           keychain.savePasswordToKeychain(account: "user_name", service: service, password: userId) // 이름도 저장
           
           /// 로그인 상태 true
           isLoggedIn = true
       }
      
       // 앱 실행 시 자동 로그인 시도
       func autoLogin() {
           
           guard isLoggedIn == false else { return }
           
           if let savedId = keychain.load(account: "user_name", service: service),
              let _ = keychain.load(account: savedId, service: service) {
               self.userId = savedId
               self.userName = savedId
               self.isLoggedIn = true
           }
       }
       
    
       func logout() {
           keychain.delete(account: userId, service: service)
           keychain.delete(account: "user_name", service: service)
           isLoggedIn = false
       }
    
    
   
}
    */
    
}
