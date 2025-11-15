//
//  MoyaService.swift
//  MegaBox
//
//  Created by 박병선 on 11/13/25.
//
import Foundation
import Moya

// MARK: - TMDB Service Protocol

protocol TMDBServicing {
    /// Now Playing 영화 목록 (completion-handler)
    func fetchNowPlaying(
        page: Int,
        language: String,
        region: String?,
        completion: @escaping (Result<MovieResponseDTO, NetworkError>) -> Void
    )
    
    /// Now Playing 영화 목록 (async/await)
    func fetchNowPlayingAsync(
        page: Int,
        language: String,
        region: String?
    ) async throws -> MovieResponseDTO
}

// MARK: - TMDBService 구현체

final class TMDBService: TMDBServicing {
    
    static let shared = TMDBService()
    private let provider: MoyaProvider<TMDBRouter> //Moya네트워크 요청 객체
    private let apiKey: String //TMDB API Key
    
    // 기본 생성자
    init(
        apiKey: String = TMDBService.defaultApiKey,
        provider: MoyaProvider<TMDBRouter> = MoyaProvider<TMDBRouter>()
    ) {
        self.apiKey = apiKey
        self.provider = provider
    }
    
    // Info.plist → TMDB_API_KEY 읽기
    private static let defaultApiKey: String = {
        let value = Bundle.main.object(forInfoDictionaryKey: "TMDB_API_KEY") as? String
        guard let key = value, key.isEmpty == false else {
            assertionFailure("TMDB_API_KEY not found in Info.plist")
            return ""
        }
        return key
    }()
    
    // MARK: - completion-handler 버전
    /* 동작 흐름
     1.    NowPlayingRequestDTO 생성
     2.    TMDBRouter.nowPlaying(requestDTO)로 라우터 세팅
     3.    provider.request(target) 호출
     4.    성공 → JSONDecoder 로 DTO 디코딩
     5.    실패 → NetworkError 반환
     */
    func fetchNowPlaying(
        page: Int = 1,
        language: String = "ko-KR",
        region: String? = nil,
        completion: @escaping (Result<MovieResponseDTO, NetworkError>) -> Void
    ) {
        let requestDTO = NowPlayingRequestDTO(
            apikey: apiKey,
            language: language,
            page: page,
            region: region
        )
        
        let target = TMDBRouter.nowPlaying(requestDTO)
        
        provider.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let dto = try decoder.decode(MovieResponseDTO.self, from: response.data)
                    completion(.success(dto))
                } catch {
                    print("[TMDBService] Decoding error: \(error)")
                    completion(.failure(.decodingError))
                }
                
            case .failure(let error):
                print("[TMDBService] Network failure: \(error)")
                completion(.failure(.networkFailure))
            }
        }
    }
    
    // MARK: - async/await 버전
    /*
     동작흐름
     1.    DTO 생성 (apiKey, language, page 등 포함)
     2.    Router로 target 설정
     3.    provider.asyncRequest(target) 실행 → async/await 기반 요청
     4.    응답 데이터를 MovieResponseDTO 로 디코딩 후 반환
     */
    func fetchNowPlayingAsync(
        page: Int = 1,
        language: String = "ko-KR",
        region: String? = nil
    ) async throws -> MovieResponseDTO {
        let requestDTO = NowPlayingRequestDTO(
            apikey: apiKey,
            language: language,
            page: page,
            region: region
        )
        
        let target = TMDBRouter.nowPlaying(requestDTO)
        
        let response = try await provider.asyncRequest(target)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(MovieResponseDTO.self, from: response.data)
    }
}

