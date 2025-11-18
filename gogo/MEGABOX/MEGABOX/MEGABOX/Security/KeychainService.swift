//
//  KeychainService.swift
//  MEGABOX
//
//  Created by 고석현 on 11/6/25.
//

//
//  KeychainService.swift

//

import Foundation
import Security

/// Keychain에 문자열을 저장/조회/삭제
/// - 앱 환경에서 "아이디/비밀번호, 토큰" 등을 안전하게 보관할 때 사용
/// - 내부적으로 kSecClassGenericPassword 영역을 사용
final class KeychainService {
    static let shared = KeychainService()

    /// 동일 기기 내 다른 앱과 키 충돌 방지
    private let service: String = Bundle.main.bundleIdentifier ?? "com.example.app"

   
    /// - 자동 로그인/백그라운드 동작을 고려하.afterFirstUnlockThisDeviceOnly 사용!!
    private let accessibility = kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly

    private init() {}

    // MARK: -  프로젝트 전역에서 재사용
    enum Key {
        static let userID = "user_id"
        static let userPassword = "user_password"
        static let userName = "user_name"
        // 필요 시: static let accessToken = "access_token"
        // 필요 시: static let refreshToken = "refresh_token"
    }

    // MARK: - 저장
    /// 값 저장(동일 키가 있으면 덮어쓰기)
    @discardableResult
    func save(_ value: String, for key: String) -> Bool {
        let data = Data(value.utf8)

        // 기존 항목 삭제 후 새로 추가(업데이트 간소화)
        delete(key)

        let query: [String: Any] = [
            kSecClass               as String: kSecClassGenericPassword,
            kSecAttrService         as String: service,
            kSecAttrAccount         as String: key,
            kSecAttrAccessible      as String: accessibility,
            kSecValueData           as String: data
        ]

        let status = SecItemAdd(query as CFDictionary, nil)
        print("🔐 Keychain Save → key: \(key), value: \(value), success: \(status == errSecSuccess)")
        return status == errSecSuccess
    }

    // MARK: - 조회
    /// 문자열로 값 조회(없으면 nil)
    func read(_ key: String) -> String? {
        let query: [String: Any] = [
            kSecClass               as String: kSecClassGenericPassword,
            kSecAttrService         as String: service,
            kSecAttrAccount         as String: key,
            kSecReturnData          as String: true,
            kSecMatchLimit          as String: kSecMatchLimitOne
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess,
              let data = item as? Data,
              let value = String(data: data, encoding: .utf8) else {
            return nil
        }
        return value
    }

    // MARK: - 삭제
    /// 항목 삭제(존재하지 않아도 false 대신 true 취급해도 무방)
    @discardableResult
    func delete(_ key: String) -> Bool {
        let query: [String: Any] = [
            kSecClass               as String: kSecClassGenericPassword,
            kSecAttrService         as String: service,
            kSecAttrAccount         as String: key
        ]
        let status = SecItemDelete(query as CFDictionary)
        print("🗑️ Keychain Delete → key: \(key), success: \(status == errSecSuccess || status == errSecItemNotFound)")
        return status == errSecSuccess || status == errSecItemNotFound
    }

    // MARK: - 다수 저장,삭제
    /// 여러 값을 한 번에 저장(모두 성공 시 true)
    @discardableResult
    func saveMany(_ pairs: [String: String]) -> Bool {
        print("🔐 Keychain SaveMany → keys: \(pairs.keys)")
        return pairs.allSatisfy { save($0.value, for: $0.key) }
    }

    /// 여러 키를 한 번에 삭제(모두 성공 시 true)
    @discardableResult
    func deleteMany(_ keys: [String]) -> Bool {
        print("🗑️ Keychain DeleteMany → keys: \(keys)")
        return keys.allSatisfy { delete($0) }
    }
}
