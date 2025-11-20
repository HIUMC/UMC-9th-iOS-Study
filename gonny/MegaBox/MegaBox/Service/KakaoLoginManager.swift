//
//  KakaoLoginManager.swift
//  MegaBox
//
//  Created by 박병선 on 11/6/25.
//
import KakaoSDKAuth
import KakaoSDKUser
import Alamofire

class KakaoLoginManager {
    let keychain = KeychainService.shared
    
    //MARK: -SDK로 인가 코드 받기
    func loginWithKakao() {
        // 카카오톡 설치 여부에 따라 분기
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { token, error in
                if let error = error {
                    print("카카오톡 로그인 실패: \(error)")
                } else {
                    print("카카오톡 로그인 성공", token ?? "")
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { token, error in
                if let error = error {
                    print("카카오계정 로그인 실패: \(error)")
                    return
                }
                print("카카오계정 로그인 성공", token ?? "")
            }
        }
    }
    
    
    //MARK: -인가코드로 토큰 요청
    func requestKakaoToken(code: String) {
        let url = "https://kauth.kakao.com/oauth/token"
        
        
        let restAPIKey = "185bc5801674da01a379cab3417016e2"
    
        let redirectURI = "https://example.com/oauth"
        
        let parameters: [String: String] = [
            "grant_type": "authorization_code",
            "client_id": restAPIKey,
            "redirect_uri": redirectURI,
            "code": code
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: parameters)
        .responseDecodable(of: KakaoTokenResponse.self) { response in
            switch response.result {
            case .success(let token):
                print(" access token: \(token.access_token)")
                // 토큰 받았으니 이제 사용자 정보 요청으로 이동
                self.fetchKakaoUserInfo(accessToken: token.access_token)
            case .failure(let error):
                print(" 토큰 요청 실패: \(error)")
                if let data = response.data,
                   let body = String(data: data, encoding: .utf8) {
                    print("서버 응답: \(body)")
                }
            }
        }
    }
    
    func fetchKakaoUserInfo(accessToken: String) {
        let url = "https://kapi.kakao.com/v2/user/me"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        AF.request(url,
                   method: .get,
                   headers: headers)
        .responseDecodable(of: KakaoUser.self) { response in
            switch response.result {
            case .success(let user):
                print(" 사용자 정보: \(user)")
                print("닉네임: \(user.kakao_account?.profile?.nickname ?? "없음")")
            case .failure(let error):
                print(" 사용자 정보 요청 실패: \(error)")
                if let data = response.data,
                   let body = String(data: data, encoding: .utf8) {
                    print("서버 응답: \(body)")
                }
            }
        }
    }
}
