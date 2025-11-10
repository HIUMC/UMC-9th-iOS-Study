//
//  AuthenticationManager.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/5/25.
//

import SwiftUI
import Observation
import KakaoSDKUser

@Observable
class AuthenticationManager {
    
    // 앱의 현재 로그인 상태 - false면 LoginView, true면 MainTabView
    var isLoggedIn: Bool = false
    
    // 생성자를 이용해서 자동 로그인 - 토큰을 체크해서 isLoggedIn을 변경
    init() {
        checkTokenStatus()
    }
    
    // 토큰의 상태를 체크해서 isLoggedIn 변수를 수정
    private func checkTokenStatus() {
        Task { @MainActor in
            self.isLoggedIn = KeychainService.shared.loadToken() // Bool타입 반환
            
            if self.isLoggedIn {
                print("AuthManager: 토큰 있음, 자동로그인 진행")
            } else {
                print("AuthManager: 토큰 없음, 자동로그인 불가")
            }
        }
    }
    
    // tokenInfo: 필수 전달인자 - 키체인에 저
    // isWithKakao: 카카오 로그인이면 true, 카카오 로그인이 아니면 false(디폴트)
    // loginID: 카카오 로그인이 아닌 경우 id 값을 넘겨받음 - 사용자 이름 구분 위함
    func login(tokenInfo: TokenInfo, isWithKakao: Bool = false, loginid: String = "", loginpwd: String = "") async {
        // 로그인 성공 시 키체인에 토큰 저장
        KeychainService.shared.saveToken(tokenInfo)
        
        // --- 카카오 로그인인지 검사 ---
        if isWithKakao { // 카카오 로그인 O
            do {
                if let userName = try await getKakaoUserName() { // getKakaoUserName() 함수를 호출하여 유저 이름 가져옴
                    UserDefaults.standard.set(userName, forKey: "name")
                }
            } catch {
                print("유저 이름 저장 불가")
            }
        } else { // 카카오 로그인 X
            // 키체인에 로그인 정보 저장
            KeychainService.shared.saveCredential(id: loginid, pwd: loginpwd)
            
            // TODO: 로그인 정보마다 사용자 이름 어떻게 저장?
            UserDefaults.standard.set("사용자", forKey: "name") // 그냥 사용자로 저장
            UserDefaults.standard.set(loginid, forKey: "id") // ID 저장
            
            // --- 하드코딩 ---
            // TODO: 로그인 정보를 서버에서 가져오도록 구현
            if loginid == "Test" { UserDefaults.standard.set("이한결", forKey: "name") }
            else if !isWithKakao { UserDefaults.standard.set("사용자", forKey: "name") }
            
        }
        
        // UI 변경에 관련된 코드는 메인 스레드에서
        await MainActor.run { isLoggedIn = true }
    }
    
    // 카카오 서버에서 카카오 로그인 정보를 바탕으로 유저 이름을 받아옴
    func getKakaoUserName() async throws -> String? {
        return try await withCheckedThrowingContinuation { continuation in
            
            // --- SDK를 통해 유저 정보를 가져옴 ---
            UserApi.shared.me { ( user, error) in
                if let error = error {
                    print("카카오 유저 정보 불러오기 실패", error)
                    continuation.resume(throwing: error)
                    // 불러온 유저 정보에서 nickname 추출하여 userName에 저장
                } else if let userName = user?.kakaoAccount?.profile?.nickname {
                    print("카카오 유저 정보 불러오기 성공")
                    continuation.resume(returning: userName)
                } else { continuation.resume(returning: "사용자") }
            }
        }
    }
    
    func logout() {
        // 키체인에서 토큰 삭제
        KeychainService.shared.deleteToken()
        if let loggedinID = UserDefaults.standard.string(forKey: "id") {
            // 키체인에 저장된 로그인 정보 삭제
            print("keychain에서 로그인 정보 삭제")
            KeychainService.shared.deleteCredential(forId: loggedinID)
        } else {
            print("아이디를 찾을 수 없음 - keychain에서 로그인 정보 삭제 불가")
        }
        
        // isLoggedIn 변수를 false로 변경
        isLoggedIn = false
    }
}
