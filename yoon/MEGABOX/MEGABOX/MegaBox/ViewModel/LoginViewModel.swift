//
//  LoginViewModel.swift
//  week1_homework
//
//  Created by 정승윤 on 9/22/25.
//

import Foundation
import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    var loginModel = LoginModel(id: "", pwd: "", name: "")
    // LoginModel의 양식을 받아와서 초깃값 설정
    
    @Published var isLoggedIn: Bool = false
    @Published var userName: String?
    
    private let keychainService = KeychainService.shared
    private let service = "com.megabox"
    
    lazy var kakaoService: KakaoLoginService = {
        return KakaoLoginService(loginVM: self) // self 주입 확인
    }()
    // 시작 시 자동 로그인
    init() {
        autoLogin()
    }
    // 자동 로그인
    func autoLogin() {
        guard let savedID = keychainService.load(account: "userId", service: "com.megabox")
                // ID -> Pwd 가져오기
        else {
            print("자동 로그인 실패 : 저장된 로그인 정보 없음")
            return
        }
        
        self.isLoggedIn = true
        self.userName = "정승윤"
        self.loginModel.id = savedID
        self.loginModel.pwd = ""
        print("자동 로그인 성공")
    }
    // 수동 로그인
    func login() {
        // 키체인 저장
        let inputId = loginModel.id
        let inputPwd = loginModel.pwd
        
        guard !loginModel.id.isEmpty, !loginModel.pwd.isEmpty else {
            print("아이디,비밀번호 입력")
            return
        }
        
        self.isLoggedIn = true
        self.userName = "정승윤"
        self.loginModel.id = inputId
        self.loginModel.pwd = ""
        
        
        keychainService.savePasswordToKeychain(account: inputId, service: service, password: inputPwd)
        keychainService.savePasswordToKeychain(account: "userId", service: service, password: inputId)
        // 정보 저장
        print("수동 로그인 성공")
        print(isLoggedIn)
    }
    
    func kakaoLogin() {
        // KakaoLoginService의 로그인 함수 호출
        kakaoService.kakaoLogin()
    }
    
    func logout() {
        self.isLoggedIn = false
        self.userName = nil
        self.loginModel.id = ""
        
        if let savedId = keychainService.load(account: "userId", service: service) {
            keychainService.delete(account: savedId, service: service)
        } // 비밀번호 삭제
        keychainService.delete(account: "userId", service: service)
        } // 아이디 삭제
    }



