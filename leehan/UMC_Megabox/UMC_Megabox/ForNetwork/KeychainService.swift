//
//  KeychainService.swift
//  UMC_Megabox
//
//  Created by 이한결 on 11/2/25.
//

import Foundation
import Security

class KeychainService {
    static let shared = KeychainService()
    
    private init() {}
    // MARK: 토큰 저장을 위한 변수
    private let account = "authToken"
    private let service = "com.myKeychain.tokenInfo"
    
    // MARK: 로그인 정보 저장을 위한 변수
    private let credentialService = "com.myKeychain.userCredential"
    
    // --- 로그인 정보 저장을 위한 새로운 함수들 ---
    
    // 로그인 정보 키체인에 저장하는 함수
    @discardableResult
    public func saveCredential(id: String, pwd: String) -> OSStatus {
        // Token객체와 다르게 pwd는 String이기 때문에 utf8로 passwordData에 저장
        guard let passwordData = pwd.data(using: .utf8) else {
            print("비밀번호를 Data로 변환하는데 실패함")
            return errSecParam
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: id,
            kSecAttrService as String: credentialService,
            kSecValueData as String: passwordData,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
        ]
        
        // 기존 항목 삭제
        SecItemDelete(query as CFDictionary)
        // 새 항목 추가
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecSuccess {
            print("[Keychain] 아이디 '\(id)'의 비밀번호 저장 성공")
        } else {
            print("[Keychain] 비밀번호 저장 실패. Status: \(status)")
        }
        
        return status
    }
    
    // id에 해당하는 키체인 로그인 정보를 삭제하는 함수
    @discardableResult
    public func deleteCredential(forId id: String) -> OSStatus {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: credentialService,
            kSecAttrAccount as String: id
        ]
        
        // 키체인에 저장된 로그인 정보 삭제
        let status = SecItemDelete(query as CFDictionary)
        
        if status == errSecSuccess {
            print("로그인 정보 삭제 성공")
        } else {
            print("로그인 정보 삭제 실패")
        }
        
        return status
    }
    
    @discardableResult
    private func saveTokenInfo(_ tokenInfo: TokenInfo) -> OSStatus {
        do {
            let data = try JSONEncoder().encode(tokenInfo)
            
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: account,
                kSecAttrService as String: service,
                kSecValueData as String: data,
                kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
            ]
            
            SecItemDelete(query as CFDictionary)
            
            return SecItemAdd(query as CFDictionary, nil)
        } catch {
            print("JSON 인코딩 실패:", error)
            return errSecParam
        }
    }
    
    private func loadTokenInfo() -> TokenInfo? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess,
              let data = item as? Data else {
            print("토큰 정보 불러오기 실패 - status:", status)
            return nil
        }
        
        do {
            return try JSONDecoder().decode(TokenInfo.self, from: data)
        } catch {
            print("❌ JSON 디코딩 실패:", error)
            return nil
        }
    }
    
    @discardableResult
    private func deleteTokenInfo() -> OSStatus {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service
        ]
        
        return SecItemDelete(query as CFDictionary)
    }
    
    public func saveToken(_ tokenInfo: TokenInfo) {
        let saveStatus = self.saveTokenInfo(tokenInfo)
        print(saveStatus == errSecSuccess ? "저장 성공" : "저장 실패")
    }
    
    // 자동로그인 구현 위해 Bool타입 반환하도록 수정
    public func loadToken() -> Bool {
        if let loadedToken = self.loadTokenInfo() { // 토큰이 있는 경우 true 반환
            print("accessToken:", loadedToken.accessToken)
            print("RefreshToken:", loadedToken.refreshToken)
            return true
        } else { // 토큰이 없는 경우 false 반환
            print("토큰 정보 없음")
            return false
        }
    }
    
    public func deleteToken() {
        let deleteStatus = self.deleteTokenInfo()
        print(deleteStatus == errSecSuccess ? "삭제 성공" : "삭제 실패")
    }
}
