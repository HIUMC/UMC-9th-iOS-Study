//
//  MovieService.swift
//  UMC_Megabox
//
//  Created by 이한결 on 11/10/25.
//

import Foundation
import Alamofire
import Moya

@Observable
final class MovieService {
    // provider 인스턴스 생성
    var provider = MoyaProvider<TMDBAPI>()

    init() {
        let logger = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
        self.provider = MoyaProvider<TMDBAPI>(plugins: [logger])
    }

    // --- API 호출: get Movie Data from TMDB ---
    func fetchMovieData() async throws -> NowPlayingResponseDomainModel {
        do {
            let response = try await withCheckedThrowingContinuation { continuation in
                provider.request(.loadMovieInfo) { result in
                    switch result {
                    case .success(let response):
                        continuation.resume(returning: response)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
            
            let dto = try response.map(NowPlayingResponseDTO.self)
            return dto.toDomain()
        } catch {
            print("fetchMovieData 실패")
            throw error
        }
    }
}
