//
//  KakaoLogin.swift
//  MEGABOX
//
//  Created by 정승윤 on 11/7/25.
//

import KakaoSDKUser
import Alamofire
import Foundation

class KakaoLoginService: ObservableObject {
    let keychain = KeychainService.shared
    let service = "KakaoLoginService"
    let tokenKey = "kakaoAccessToken"
    
    weak var loginVM: LoginViewModel?

        init(loginVM: LoginViewModel? = nil) {
            self.loginVM = loginVM
        }
    //MARK: - 1. 인가코드 받아오기
    func kakaoLogin() {
        // 카카오톡 실행 가능 여부 확인
        if UserApi.isKakaoTalkLoginAvailable() {
            // 카카오톡 로그인
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    print(error)
                } else if let token = oauthToken?.accessToken{
                    print("카카오톡 로그인 success")
                    
                    self.keychain.savePasswordToKeychain(account: self.tokenKey,
                                                                         service: self.service,
                                                                         password: token)
                    self.getUserInfo(accessToken: token)
                }
            }
        } else {
            // 카카오계정 로그인
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    print(error)
                } else if let token = oauthToken?.accessToken {
                    print("카카오계정 로그인 success")
                    
                    // 토큰 키체인 저장
                    self.keychain.savePasswordToKeychain(account: self.tokenKey,
                                                         service: self.service,
                                                         password: token)
                    
                    // 사용자 정보 가져오기
                    self.getUserInfo(accessToken: token)
                }
            }
        }
    }
    
    //MARK: - 2. 인가코드로 토큰 받아오기
//    func getToken(code:String) {
//        let url = "https://kauth.kakao.com/oauth/token"
//        
//        let restAPIKey = "7866a3d89afcf1ae347051d1edef8fed"
//        let redirectURI = "https://example.com/oauth"
//        
//        let parameters: [String:String] = [
//            "grant_type": "authorization_code",
//            "client_id": restAPIKey,
//            "redirect_uri" : redirectURI,
//            "code" : code
//        ]
//        
//        AF.request(url, method: .post, parameters: parameters).responseDecodable(of: KakaoToken.self) { response in
//            switch response.result {
//            case .success(let token):
//                print("액세스토큰: \(token.access_token)")
//                
//                // 키체인에 저장
//                self.keychain.savePasswordToKeychain(account: self.tokenKey,  service: self.service, password: token.access_token)
//                
//                self.getUserInfo(accessToken: token.access_token)
//            case .failure(let error):
//                print("토큰 발급 실패")
//            }
//        }
//    }
    
    //MARK: - 3. 사용자 로그인 처리
    func getUserInfo(accessToken:String) {
        let url = "https://kapi.kakao.com/v2/user/me"
        let header: HTTPHeaders = ["Authorization" : "Bearer \(accessToken)"]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: KakaoUser.self) {response in
            switch response.result {
            case .success(let info):
                print("아이디: \(info)")
                if let profile = info.kakao_account?.profile {
                                print("닉네임: \(profile.nickname ?? "없음")")
                            }
                DispatchQueue.main.async {
                           self.loginVM?.isLoggedIn = true
                       }
            case .failure(let error):
                print("정보 가져오기 실패")
            }
            
        }
    }
}
