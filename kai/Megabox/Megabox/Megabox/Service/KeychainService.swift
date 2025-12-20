//
//  KeychainService.swift
//  Megabox
//
//  Created by 김지우 on 11/6/25.
//

import Foundation
import Security

class KeychainService {
    
    static let shared = KeychainService()
    
    // 일반 로그인 토큰을 위한 키체인 속성
    private let standardLoginService = "com.myKeychain.standardLogin"
    private let standardLoginAccount = "userTokens"
    
    // 카카오 로그인 토큰을 위한 키체인 속성
    private let kakaoLoginService = "com.myKeychain.kakaoLogin"
    private let kakaoLoginAccount = "kakaoTokens"
    
    private init() {}
    
    // MARK: - Private Generic Helpers
    
    @discardableResult
    private func save(service: String, account: String, data: Data) -> OSStatus {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock // 앱 잠금 해제 이후에만 접근 가능
        ]
        
        //기존에 있던 아이템 삭제
        SecItemDelete(query as CFDictionary)
        
        //새 아이템 추가
        return SecItemAdd(query as CFDictionary, nil)
    }
    
    private func load(service: String, account: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,       // 데이터를 반환
            kSecMatchLimit as String: kSecMatchLimitOne // 하나의 아이템만
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess, let data = item as? Data else {
            print("Keychain: \(service) load failed (Status: \(status))") // 디버깅용
            return nil
        }
        return data
    }
    
    @discardableResult
    private func delete(service: String, account: String) -> OSStatus {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        
        return SecItemDelete(query as CFDictionary)
    }
    
    // MARK: - Private Token En/Decode Helpers
    
    private func saveToken(service: String, account: String, tokenInfo: TokenInfo) {
        do {
            let data = try JSONEncoder().encode(tokenInfo)
            let status = save(service: service, account: account, data: data)
            print(status == errSecSuccess ? "Keychain: \(service) save success" : "Keychain: \(service) save failed (Status: \(status))")
        } catch {
            print("Keychain: JSON encoding failed: \(error)")
        }
    }
    
    private func loadToken(service: String, account: String) -> TokenInfo? {
        guard let data = load(service: service, account: account) else {
            return nil
        }
        
        do {
            return try JSONDecoder().decode(TokenInfo.self, from: data)
        } catch {
            print("Keychain: JSON decoding failed: \(error)")
            // 디코딩 실패 시 (구조체 변경 등) 저장된 값을 삭제하는 것이 좋다
            // delete(service: service, account: account)
            return nil
        }
    }

    // MARK: - Public API for Standard Login (Part 1)
    
    /// 일반 로그인 성공 시 받은 토큰을 저장
    public func saveStandardLoginToken(_ tokenInfo: TokenInfo) {
        self.saveToken(service: standardLoginService, account: standardLoginAccount, tokenInfo: tokenInfo)
    }
    
    /// 앱 실행 시 자동 로그인을 위해 일반 로그인 토큰을 불러옴
    public func loadStandardLoginToken() -> TokenInfo? {
        return self.loadToken(service: standardLoginService, account: standardLoginAccount)
    }
    
    /// 로그아웃 시 일반 로그인 토큰을 삭제합니다.
    public func deleteStandardLoginToken() {
        let status = self.delete(service: standardLoginService, account: standardLoginAccount)
        print(status == errSecSuccess ? "Keychain: Standard token deleted" : "Keychain: Standard token delete failed (Status: \(status))")
    }
    
    
    /// 카카오 로그인 성공 시 받은 토큰을 저장
    public func saveKakaoLoginToken(_ tokenInfo: TokenInfo) {
        self.saveToken(service: kakaoLoginService, account: kakaoLoginAccount, tokenInfo: tokenInfo)
    }
    
    /// 카카오 로그인 토큰을 불러옴
    public func loadKakaoLoginToken() -> TokenInfo? {
        return self.loadToken(service: kakaoLoginService, account: kakaoLoginAccount)
    }
    
    /// 카카오 로그아웃 시 토큰 삭제
    public func deleteKakaoLoginToken() {
        let status = self.delete(service: kakaoLoginService, account: kakaoLoginAccount)
        print(status == errSecSuccess ? "Keychain: Kakao token deleted" : "Keychain: Kakao token delete failed (Status: \(status))")
    }
}
