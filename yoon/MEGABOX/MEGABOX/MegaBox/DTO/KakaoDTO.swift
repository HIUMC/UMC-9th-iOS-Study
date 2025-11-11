//
//  KakaoDTO.swift
//  MEGABOX
//
//  Created by 정승윤 on 11/7/25.
//

import Foundation

struct KakaoToken: Decodable {
    let token_type: String
    let access_token: String
    let expires_in : Int
    let refresh_token: String
    let refresh_token_expires_in: Int
}

struct KakaoUser: Decodable {
    let id: Int
    let kakao_account: KakaoAccount?
}

struct KakaoAccount: Decodable {
    let email: String?
    let profile: KakaoProfile?
}

struct KakaoProfile: Decodable {
    let nickname: String?
    let profile_image_url: String?
}
