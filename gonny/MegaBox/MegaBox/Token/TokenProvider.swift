//
//  TokenProvider.swift
//  MegaBox
//
//  Created by 박병선 on 11/13/25.
//
import Foundation
import Moya

class TokenProvider: TokenProviding {
    private let userSession = "appNameUser"
    private let keyChain = KeychainService.shared
    private let provider = MoyaProvider<AuthRouter>()
    
    var accessToken: String? {
        get {
            guard let userInfo = keyChain.loadToken() else { return nil }
            return userInfo.accessToken
        }
        set {
            guard var userInfo = keyChain.loadToken() else { return }
            userInfo.accessToken = newValue ?? "토큰 정보 없음"
            keyChain.saveToken(userInfo)
        }
    }
    
    var refreshToken: String? {
        get {
            guard let userInfo = keyChain.loadToken() else { return nil }
            return userInfo.refreshToken
        }
        
        set {
            guard var userInfo = keyChain.loadToken() else { return }
            userInfo.refreshToken = newValue ?? "토큰 정보 없음"
            keyChain.saveToken(userInfo)
        }
    }
    
    func refreshToken(completion: @escaping (String?, (any Error)?) -> Void) {
        guard let userInfo = keyChain.loadToken() else {
            let error = NSError(domain: "example.com", code: -2, userInfo: [NSLocalizedDescriptionKey: "UserSession or refreshToken not found"])
            completion(nil, error)
            return
        }
        let refreshToken = userInfo.refreshToken
        
        provider.request(.sendRefreshToken(refreshToken: refreshToken)) { result in
            switch result {
            case .success(let response):
                if let jsonString = String(data: response.data, encoding: .utf8) {
                    print("응답 JSON: \(jsonString)")
                } else {
                    print("JSON 데이터를 문자열로 변환할 수 없습니다.")
                }

                do {
                    
                    let tokenData = try JSONDecoder().decode(TokenInfo.self, from: response.data)

                    
                    self.accessToken = tokenData.accessToken
                    self.refreshToken = tokenData.refreshToken

                    completion(self.accessToken, nil)
                } catch {
                    print("디코딩 에러: \(error)")
                    completion(nil, error)
                }

            case .failure(let error):
                print("네트워크 에러 : \(error)")
                completion(nil, error)
            }
        }
    }
    
}
