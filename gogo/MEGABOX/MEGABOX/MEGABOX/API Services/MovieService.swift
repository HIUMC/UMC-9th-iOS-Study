//
//  MovieService.swift
//  MEGABOX
//
//  Created by 고석현 on 11/12/25.
//

import Foundation
import Moya

// MARK: - MovieService 파일 !!!!
final class MovieService {
    static let shared = MovieService() // 싱글톤!
    private let provider = MoyaProvider<MovieEndpoints>()
    
    private init() {}
    
    // MARK: - Now Playing 현재 상영중 영화 목록 요청~!
    func fetchNowPlayingMovies(
        completion: @escaping (Result<MovieResponseDTO, NetworkError>) -> Void
    ) {
        print("🎬 [MovieService] Now Playing 영화 데이터 요청 시작...")
        
        provider.request(.nowPlaying) { result in
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedData = try decoder.decode(MovieResponseDTO.self, from: response.data)
                    
                    print("✅ [MovieService] 영화 데이터 로딩 성공 (\(decodedData.results.count)편)")
                    decodedData.results.prefix(3).forEach { movie in
                        print("""
                        🎞️ [DEBUG] Movie:
                            Title: \(movie.title ??  "제목 없음")
                            Poster Path: \(movie.posterPath ?? "nil")
                            Overview: \(movie.overview ?? "nil")
                            Release Date: \(movie.releaseDate ?? "nil")
                        """)
                    }
                    completion(.success(decodedData))
                    
                } catch {
                    print("❌ [MovieService] 디코딩 실패: \(error.localizedDescription)")
                    if let jsonString = String(data: response.data, encoding: .utf8) {
                        print("📄 [DEBUG] Response Raw JSON: \(jsonString)")
                    }
                    completion(.failure(.decodingError))
                }
                
            case .failure(let error):
                print("🚨 [MovieService] 네트워크 요청 실패: \(error.localizedDescription)")
                completion(.failure(.networkFailure))
            }
        }
    }
    

    // MARK: - async/await 버전으로도 ! (로그로 서버랑 연결 확인 가능)
    func fetchNowPlayingMoviesAsync() async throws -> MovieResponseDTO {
        print("🎬 [MovieService] async/await 로딩중...")

        // ✅ 디버그용 로그 추가
        let target = MovieEndpoints.nowPlaying
        print("""
        🌐 [DEBUG-REQUEST]
          ➤ Base URL: \(target.baseURL)
          ➤ Path: \(target.path)
          ➤ Full URL: \(target.baseURL)\(target.path)
          ➤ Method: \(target.method)
          ➤ Headers: \(target.headers ?? [:])
        """)

        // params 로그도 찍기 (있다면)
        if case let .requestParameters(parameters, _) = target.task {
            print("      ➤ Parameters: \(parameters)")
        }

        // 요청 실행
        let response = try await provider.asyncRequest(target)
        print("✅ [MovieService] async 로딩 성공")

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedData = try decoder.decode(MovieResponseDTO.self, from: response.data)

        print("✅ [MovieService] 영화 데이터 로딩 성공 (\(decodedData.results.count)편)")
        decodedData.results.prefix(3).forEach { movie in
            print("""
            🎞️ [DEBUG-ASYNC] Movie:
                Title: \(movie.originalTitle ?? movie.title ?? "제목 없음")
                Poster Path: \(movie.posterPath ?? "nil")
                Overview: \(movie.overview ?? "nil")
                Release Date: \(movie.releaseDate ?? "nil")
            """)
        }

        return decodedData
    }
}

// MARK: - NetworkError Enum
enum NetworkError: Error {
    case decodingError
    case networkFailure
    case unknown
}

// MARK: - MoyaProvider async/await 확장
private extension MoyaProvider {
    func asyncRequest(_ target: Target) async throws -> Response {
        try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
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
