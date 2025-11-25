//
//  Secret.swift
//  MegaBox
//
//  Created by 박병선 on 11/13/25.
//
import Foundation

enum Secret {
    static let tmdbApiKey: String = {
        Bundle.main.infoDictionary?["TMDB_API_KEY"] as? String ?? ""
    }()

    static let tmdbReadAccessToken: String = {
        Bundle.main.infoDictionary?["TMDB_READ_TOKEN"] as? String ?? ""
    }()
}
