//
//  LoginViewModel.swift
//  UMC_Megabox
//
//  Created by OOng E on 9/22/25.
//

import SwiftUI
import Observation
import Alamofire
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser


enum LoginError: Error {
    case invalidCredentials
    case networkFailed
    case unknown
}

@Observable
class LoginViewModel {
    /* LoginViewModel 에서 LoginModel 초기화 */
    var loginModel: LoginModel = .init(id: "", pwd: "")
    
    func loginButtonTapped() async throws -> TokenInfo {
        // 서버에 id, pw를 보내서 토큰을 요청함
        // let tokenInfo = try? await APIService.shared.login(id: id, password: pw)
        
        // --- 하드코딩 --- 
        if loginModel.id == "Test" && loginModel.pwd == "1234" {
            print("로그인 시뮬레이션 성공")
            return TokenInfo(accessToken: "MOCK_ACCESS_TOKEN", refreshToken: "MOCK_REFRESH_TOKEN")
        } else {
            print("로그인 시뮬레이션 실패")
            throw LoginError.invalidCredentials
        }
    }
    
    func kakaoLoginButtonTapped() async throws -> TokenInfo {
        
        // 인가 코드 요청 + 토큰 받아와서 oauthToken에 저장
        let oauthToken = try await getAuthTokenFromSDK()
        
        // 받아온 토큰을 tokenInfo에 TokenInfo 객체로 저장
        let tokenInfo = TokenInfo(accessToken: oauthToken.accessToken, refreshToken: oauthToken.refreshToken)
        
        return tokenInfo
    }
    
    
    private func getAuthTokenFromSDK() async throws -> OAuthToken {
        return try await withCheckedThrowingContinuation { continuation in
            // 카카오톡 앱 설치 여부 확인 - 카카오톡 앱 O
            if UserApi.isKakaoTalkLoginAvailable() {
                // 카카오톡 앱으로 로그인 시도
                UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                    if let error = error {
                        print("카카오톡 로그인 실패", error)
                        continuation.resume(throwing: error)
                    } else if let oauthToken = oauthToken {
                        print("카카오톡 로그인 성공(토큰 수신)")
                        continuation.resume(returning: oauthToken)
                    }
                }
            } else { // 카카오톡 앱 X
                // 웹으로 로그인 시도
                UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                    if let error = error {
                        print("카카오톡 로그인 실패", error)
                        continuation.resume(throwing: error)
                    } else if let oauthToken = oauthToken {
                        print("카카오톡 로그인 성공(토큰 수신)")
                        continuation.resume(returning: oauthToken)
                    }
                }
            }
        }
    }
    
}


