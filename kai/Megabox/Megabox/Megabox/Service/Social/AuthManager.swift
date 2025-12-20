//
//  AuthManager.swift
//  Megabox
//
//  Created by 김지우 on 11/6/25.
//

import Foundation
import SwiftUI
import Alamofire

// 카카오 API 응답을 디코딩하기 위한 구조체들
struct KakaoUserResponse: Decodable {
    let id: Int64
    let properties: KakaoUserProperties?
    let kakaoAccount: KakaoAccount?
    
    var nickname: String {
        return properties?.nickname ?? kakaoAccount?.profile?.nickname ?? "고객"
    }
}

struct KakaoUserProperties: Decodable {
    let nickname: String?
}

struct KakaoAccount: Decodable {
    let profile: KakaoProfile?
}

struct KakaoProfile: Decodable {
    let nickname: String?
}


@MainActor
@Observable
class AuthManager {
    
    // MARK: - Published Properties
    
    var isAuthenticated: Bool = false
    var userName: String?
    
    // MARK: - Private Properties
    
    private var currentToken: TokenInfo?
    
    // MARK: - Initialization (Auto-Login)
    
    init() {
        // Part 1: 자동 로그인 요구사항 구현
        if let token = KeychainService.shared.loadStandardLoginToken() {
            // (실제 앱에서는 이 토큰이 유효한지 서버에 검증해야 함)
            
            // 1. 메모리에 토큰 로드
            self.currentToken = token
            
            // 2. 앱 실행 동안 사용할 이름 로드 (임시 저장)
            // (이름은 키체인이 아닌 다른 곳(예: UserDefaults)에 저장하거나
            // 토큰 검증 시 서버에서 매번 받아오는 것이 일반적입니다.)
            // 여기서는 과제 요구사항에 따라 userName은 앱 실행 시 비어있도록 둡니다.
            // self.userName = ...
            
            // 3. 인증 상태를 true로 변경
            self.isAuthenticated = true
            
            print("AuthManager: 'Standard Login' 토큰을 로드하여 자동 로그인 성공.")
            
        } else {
            // Part 2 요구사항 (카카오 로그인은 자동로그인 안 함)
            self.isAuthenticated = false
            print("AuthManager: 저장된 토큰이 없어 로그인 화면으로 시작합니다.")
        }
    }
    
    // MARK: - Public Methods: Login (Part 1)
    
    func performStandardLogin(name: String, id: String, pwd: String) {
        // (서버 로그인 API 호출 시뮬레이션)
        print("AuthManager: 'Standard Login' 시뮬레이션 시작. (ID: \(id))")
        
        let fakeAccessToken = "fake_access_token_for_\(id)"
        let fakeRefreshToken = "fake_refresh_token_for_\(id)"
        let tokenInfo = TokenInfo(accessToken: fakeAccessToken, refreshToken: fakeRefreshToken)
        
        // 1. [키체인] '일반' 토큰 저장
        KeychainService.shared.saveStandardLoginToken(tokenInfo)
        
        // 2. [AuthManager] 현재 세션 상태 업데이트
        self.currentToken = tokenInfo
        self.userName = name // 마이페이지용 이름
        self.isAuthenticated = true
    }
    
    // MARK: - Public Methods: Login (Part 2)
    
    func performKakaoLogin(authCode: String) async {
        print("AuthManager: 'Kakao Login' 시작. (Code: \(authCode))")
        
        // 1. [Alamofire] 인가 코드로 토큰 요청
        guard let tokenInfo = await requestKakaoToken(authCode: authCode) else {
            print("AuthManager: 카카오 토큰 받기 실패")
            return
        }
        
        // 2. [키체인] '카카오' 토큰 저장
        KeychainService.shared.saveKakaoLoginToken(tokenInfo)
        print("AuthManager: 카카오 토큰 키체인 저장 성공.")
        
        // 3. [Alamofire] 발급받은 토큰으로 사용자 정보 요청
        guard let userInfo = await requestKakaoUserInfo(accessToken: tokenInfo.accessToken) else {
            print("AuthManager: 카카오 사용자 정보 받기 실패")
            let name = "고객"
            self.currentToken = tokenInfo
            self.userName = name
            self.isAuthenticated = true
            return
        }
        
        // 4. [AuthManager] 현재 세션 상태 업데이트
        let name = userInfo.nickname
        print("AuthManager: 카카오 사용자 이름 '\(name)' 획득.")
        self.currentToken = tokenInfo
        self.userName = name
        self.isAuthenticated = true
    }
    
    // MARK: - Public Methods: Logout
    
    func performLogout() {
        print("AuthManager: 로그아웃 수행. 모든 토큰과 사용자 정보 삭제.")
        
        // 1. [키체인] 일반 토큰 삭제
        KeychainService.shared.deleteStandardLoginToken()
        
        // 2. [키체인] 카카오 토큰 삭제
        KeychainService.shared.deleteKakaoLoginToken()
        
        // 3. [AuthManager] 현재 세션 상태 초기화
        self.currentToken = nil
        self.userName = nil
        self.isAuthenticated = false
    }
    
    // MARK: - Private Kakao API Helpers (Alamofire)
    
    private func requestKakaoToken(authCode: String) async -> TokenInfo? {
        let url = "https://kauth.kakao.com/oauth/token"
        let parameters: [String: String] = [
            "grant_type": "authorization_code",
            "client_id": Config.kakaoRestApiKey,
            "redirect_uri": Config.kakaoRedirectUri,
            "code": authCode
        ]
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let tokenInfo = try await AF.request(url,
                                                 method: .post,
                                                 parameters: parameters,
                                                 encoder: URLEncodedFormParameterEncoder.default)
                                        .validate(statusCode: 200..<300)
                                        .serializingDecodable(TokenInfo.self, decoder: decoder)
                                        .value
            return tokenInfo
        } catch {
            print("Error: requestKakaoToken failed - \(error.localizedDescription)")
            return nil
        }
    }
    
    private func requestKakaoUserInfo(accessToken: String) async -> KakaoUserResponse? {
        let url = "https://kapi.kakao.com/v2/user/me"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        do {
            let userInfo = try await AF.request(url,
                                                method: .get,
                                                headers: headers)
                                       .validate(statusCode: 200..<300)
                                       .serializingDecodable(KakaoUserResponse.self)
                                       .value
            return userInfo
        } catch {
            print("Error: requestKakaoUserInfo failed - \(error.localizedDescription)")
            return nil
        }
    }
}
