//
//  AuthDTO.swift
//  MegaBox
//
//  Created by 박병선 on 11/6/25.
//
import Foundation

struct KakaoUser: Decodable {
    let id: Int
    let kakao_account: KakaoAccount?
}

struct KakaoAccount: Decodable {
    let profile: KakaoProfile?
    let email: String?
}

struct KakaoProfile: Decodable {
    let nickname: String?
    let profile_image_url: String?
}

struct KakaoTokenResponse: Decodable {
    let access_token: String
    let token_type: String
    let refresh_token: String?
    let expires_in: Int?
    let scope: String?
}

