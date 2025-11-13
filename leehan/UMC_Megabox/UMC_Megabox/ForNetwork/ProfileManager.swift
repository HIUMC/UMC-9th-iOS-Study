//
//  ProfileManager.swift
//  UMC_Megabox
//
//  Created by 이한결 on 11/12/25.
//

import Foundation
import Observation
import KakaoSDKUser

class ProfileManager {
    
    static let profileManager = ProfileManager()
    
    // 카카오 서버에서 카카오 로그인 정보를 바탕으로 유저 이름을 받아옴
    func getKakaoUserName() async throws -> String? {
        return try await withCheckedThrowingContinuation { continuation in
            
            // --- SDK를 통해 유저 정보를 가져옴 ---
            UserApi.shared.me { ( user, error) in
                if let error = error {
                    print("카카오 유저 정보 불러오기 실패", error)
                    continuation.resume(throwing: error)
                    // 불러온 유저 정보에서 nickname 추출하여 userName에 저장
                } else if let userName = user?.kakaoAccount?.profile?.nickname {
                    print("카카오 유저 정보 불러오기 성공")
                    continuation.resume(returning: userName)
                } else { continuation.resume(returning: "사용자") }
            }
        }
    }
}
