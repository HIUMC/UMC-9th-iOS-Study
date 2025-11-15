//
//  Secret.swift
//  MEGABOX
//
//  Created by 고석현 on 11/12/25.
//

import Foundation


// Secret.swift
// MEGABOX

import Foundation

enum Secret {
    static var kakaoNativeAppKey: String {
        Bundle.main.object(forInfoDictionaryKey: "KAKAO_NATIVE_APP_KEY") as? String ?? ""
    }

    static var tmdbAPIKey: String {
        Bundle.main.object(forInfoDictionaryKey: "TMDB_API_KEY") as? String ?? ""
    }

    static var tmdbReadAccessToken: String {
        Bundle.main.object(forInfoDictionaryKey: "TMDB_READ_ACCESS_TOKEN") as? String ?? ""
    }
}
