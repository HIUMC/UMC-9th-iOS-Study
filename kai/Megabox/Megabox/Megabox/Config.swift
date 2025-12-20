//
//  Config.swift
//  Megabox
//
//  Created by 김지우 on 11/6/25.
//

import Foundation

// Info.plist에서 값을 읽어와 앱 전역에서 사용할 수 있게 해주는 헬퍼
enum Config {
    
    /// Info.plist에서 키 값을 가져오는 내부 함수
    private static func value<T>(for key: String) -> T {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
            fatalError("Info.plist에 \(key) 키가 설정되지 않았습니다.")
        }
        guard let value = object as? T else {
            fatalError("Info.plist의 \(key) 키가 예상된 타입(\(T.self))이 아닙니다.")
        }
        return value
    }
    
    //xcconfig -> Info.plist를 통해 주입된 값
    static let kakaoRestApiKey: String = value(for: "KakaoRestApiKey")
    static let kakaoNativeAppKey: String = value(for: "KakaoNativeAppKey")
    
    //Info.plist 값을 조합하여 URI 생성
    static let kakaoRedirectUri: String = "kakao\(kakaoNativeAppKey)://oauth"
}
