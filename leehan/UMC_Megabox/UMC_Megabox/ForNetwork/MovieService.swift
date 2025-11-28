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
            /// Moya는 async/await 방식의 최신 비동기 호출을 지원하지 않음
            /// 따라서 withCheckedThrowingContinuation 을 이용해서 async/await를 사용할 수 있도록 만들어줌
            let response = try await withCheckedThrowingContinuation { continuation in
                // provider.request(.loadMovieInfo) -> .loadMovieInfo API 호출
                provider.request(.loadMovieInfo) { result in
                    switch result {
                    case .success(let response): // 성공 시
                        continuation.resume(returning: response)
                    case .failure(let error): // 실패 시
                        continuation.resume(throwing: error)
                    }
                }
            }
            
            // response에 들어간 json 데이터를 map함수를 사용해서 NowPlayingResponseDTO 객체로 변환해서 dto에 저장
            let dto = try response.map(NowPlayingResponseDTO.self)
            // dto.toDomain() 을 통해 DomainModel로 변환한 후 리턴
            return dto.toDomain()
        } catch {
            print("fetchMovieData 실패")
            throw error
        }
    }
}
