//
//  Config.swift
//  MegaBox
//
//  Created by 박병선 on 11/13/25.
//
// 앱의 설정값(Config값)을 안전하게 불러오는 유틸리티
import Foundation

enum Config {
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist 없음")
        }
        return dict
    }()
    
    static let baseUrl: String = {
        guard let baseUrl = Config.infoDictionary["BASE_URL"] as? String else {
            fatalError()
        }
        return baseUrl
    }()
    
    static let kakaoKey: String = {
        guard let kakaoKey = Config.infoDictionary["KAKAO_KEY"] as? String else {
            fatalError()
        }
        return kakaoKey
    }()
}
