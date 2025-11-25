//
//  KeychainService.swift
//  MegaBox
//
//  Created by 이서현 on 11/5/25.
//
import Foundation
import Security

class KeychainService {
    
    static let shared = KeychainService()
    
        private init() {}
    
    /// Keychain에 사용자의 비밀번호를 저장합니다.
    /// 이미 동일한 계정과 서비스 조합의 항목이 존재하는 경우, 기존 항목을 삭제하고 새로 저장합니다.
    /// - Parameters:
    ///   - account: 아이디/이메일
    ///   - service: 비밀번호가 사용되는 서비스 이름 (예: "com.example.myapp.login")
    ///   - password: 비밀번호
    /// - Returns: 저장 작업의 결과 상태 코드 (예: `errSecSuccess`면 성공)
    @discardableResult
    func savePasswordToKeychain(account: String, service: String, password: String) -> OSStatus {
        // 1. 저장할 데이터를 Data 타입으로 변환
        guard let passwordData = password.data(using: .utf8) else {
            return errSecParam // 잘못된 데이터
        }

        // 2. Keychain Item 딕셔너리 구성
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,  // 저장 유형: 일반 비밀번호
            kSecAttrAccount as String: account,             // 계정 식별자
            kSecAttrService as String: service,             // 서비스 이름
            kSecValueData as String: passwordData,          // 실제 저장할 데이터
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked // 접근 가능 조건
        ]

        // 3. 이미 같은 항목이 있다면 삭제 (중복 방지)
        SecItemDelete(query as CFDictionary)

        // 4. 새 항목 추가
        let status = SecItemAdd(query as CFDictionary, nil)
        return status
    }

    /// Keychain에서 저장된 데이터를 불러옵니다.
    /// - Parameters:
    ///   - account: 계정 식별자 (예: 이메일 주소)
    ///   - service: 서비스 이름 (예: "com.myapp.login")
    /// - Returns: 저장된 문자열 데이터 (ex: 비밀번호, 토큰 등) 또는 nil
    @discardableResult
    func load(account: String, service: String) -> String? {
        // 1. 검색 쿼리 구성
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,   // 일반 비밀번호 클래스
            kSecAttrAccount as String: account,              // 계정
            kSecAttrService as String: service,              // 서비스
            kSecReturnData as String: true,                  // 데이터를 반환하도록 요청
            kSecMatchLimit as String: kSecMatchLimitOne      // 하나만 반환
        ]

        // 2. 검색 결과 저장 변수
        var item: CFTypeRef?

        // 3. Keychain에서 항목 검색
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        // 4. 상태 확인 및 결과 처리
        guard status == errSecSuccess else {
            print("Keychain load 실패 - status: \(status)")
            return nil
        }

        // 5. Data → String 변환
        guard let data = item as? Data,
              let result = String(data: data, encoding: .utf8) else {
            print("Keychain load 실패 - 데이터 디코딩 실패")
            return nil
        }

        return result
    }
    
    /// Keychain에서 지정된 계정과 서비스에 해당하는 항목을 삭제합니다.
       /// - Parameters:
       ///   - account: 계정 식별자 (예: 사용자 이메일)
       ///   - service: 서비스 이름 (예: "com.example.myapp")
       /// - Returns: Keychain 삭제 작업의 상태 코드 (`errSecSuccess` 등)
       @discardableResult
       func delete(account: String, service: String) -> OSStatus {
           // 1. 삭제할 항목을 식별할 쿼리 구성
           let query: [String: Any] = [
               kSecClass as String: kSecClassGenericPassword,   // 삭제 대상 유형
               kSecAttrAccount as String: account,              // 계정 식별자
               kSecAttrService as String: service               // 서비스 구분자
           ]

           // 2. 항목 삭제 시도
           let status = SecItemDelete(query as CFDictionary)

           // 3. 상태 확인 및 로그 출력
           if status == errSecSuccess {
               print("Keychain 삭제 성공 - [\(service) : \(account)]")
           } else if status == errSecItemNotFound {
               print("Keychain 항목 없음 - [\(service) : \(account)]")
           } else {
               print("Keychain 삭제 실패 - status: \(status)")
           }

           return status
       }
    
    
    
}
