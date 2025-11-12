//
//  TMDBService.swift
//  MEGABOX
//
//  Created by 박정환 on 11/12/25.
//

import Foundation
import Moya

final class TMDBService {
    let provider = MoyaProvider<TMDBAPI>()
    
    func request(_ target: TMDBAPI) async throws -> Response {
        try await withCheckedThrowingContinuation { continuation in
            provider.request(target) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
