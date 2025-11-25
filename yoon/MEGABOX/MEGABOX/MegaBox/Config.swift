//
//  Config.swift
//  MEGABOX
//
//  Created by 정승윤 on 11/12/25.
//

import Foundation

enum Config {
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist 없음")
        }
        return dict
    }()
    
    static let baseURL: String = {
        guard let baseURL = Config.infoDictionary["BASE_URL"] as? String else {
            fatalError()
        }
        return baseURL
    }()
    
    static let tmdbAPIKey: String = {
            guard let apiKey = Config.infoDictionary["TMDB_API_KEY"] as? String else {
                fatalError("🚨 Info.plist에 TMDB_API_KEY 키가 설정되지 않았습니다.")
            }
            return apiKey
        }()
}
