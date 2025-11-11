//
//  KeychainService.swift
//  MEGABOX
//
//  Created by 박정환 on 11/7/25.
//

import Foundation
import Security

final class KeychainService {

    static let shared = KeychainService()
    private init() {}

    // MARK: - Save
    func save(_ value: String, for key: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }

        // 동일 키가 이미 존재하면 삭제
        delete(key)

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,  // 일반 비밀번호 저장용
            kSecAttrAccount as String: key,                  // Key 이름
            kSecValueData as String: data                    // 실제 데이터
        ]

        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }

    // MARK: - Read
    func read(_ key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,         // 실제 데이터를 반환
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess,
              let data = item as? Data,
              let value = String(data: data, encoding: .utf8)
        else {
            return nil
        }

        return value
    }

    // MARK: - Delete
    func delete(_ key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        SecItemDelete(query as CFDictionary)
    }

    // MARK: - Clear All (옵션)
    func clearAll() {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword]
        SecItemDelete(query as CFDictionary)
    }
}
