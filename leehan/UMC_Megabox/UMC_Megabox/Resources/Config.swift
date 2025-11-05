//
//  Config.swift
//  UMC_Megabox
//
//  Created by 이한결 on 11/4/25.
//

import Foundation

enum Config {
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist 없음")
        }
        return dict
    }()
    
    static let nativeAppKey: String = {
        guard let baseURL = Config.infoDictionary["NATIVE_APP_KEY"] as? String else {
            fatalError()
        }
        return baseURL
    }()
}
