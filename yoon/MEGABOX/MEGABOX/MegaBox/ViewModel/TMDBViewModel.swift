//
//  MovieCardViewModel.swift
//  MEGABOX
//
//  Created by 정승윤 on 11/12/25.
//

import Foundation
import Moya
import Observation

@Observable
final class TMDBViewModel: ObservableObject{
    
    // MoyaProvider 인스턴스
    private let provider = MoyaProvider<TMDBAPI>()
    
    // UI에 바인딩될 데이터 (Published)
    var movieCards: [MovieCardModel] = []
    var errorMessage: String?
    
    // 하드코딩 값 (TMDB API에 없는 데이터)
    private let hardcodedAttendance = "500,000명" // 누적 관객수
    private let hardcodedRating = "15세 이상 관람가" // 영화 관람 등급
    
    // MARK: - API 호출 및 DTO 매핑
    
    @MainActor // UI 업데이트는 메인 스레드에서 이루어져야 합니다.
    func fetchNowPlayingMovies() async {
        self.errorMessage = nil
        // 초기화
        let requestDTO = RequestDTO(language: "ko-KR", page: 1, region: "KR")
        // TargetType Enum이라고 가정
        let target = TMDBAPI.getMovie(request: requestDTO)
         
        do {
            // 1. MoyaProvider를 async/await로 호출
            // provider.requestAsync(target)을 await하여 Response를 즉시 받습니다.
            let response = try await provider.requestAsync(target)
            
            if let jsonString = String(data: response.data, encoding: .utf8) {
                            print("[TMDB RAW RESPONSE]: \(jsonString)")
                        } else {
                            print("[TMDB RAW RESPONSE]: Data could not be converted to string.")
                        }
            
            // 2. 응답 데이터를 Response DTO로 디코딩
            let responseDTO = try JSONDecoder().decode(ResponseDTO.self, from: response.data)
            
            // 3. DTO의 데이터를 앱 모델로 매핑 (toMovieCardModel 사용)
            let attendance = self.hardcodedAttendance
            let rating = self.hardcodedRating
            self.movieCards = responseDTO.results.map { dto in
                // DTO 확장 함수 사용
                dto.toMovieCardModel(hardcodedAttendance: attendance, hardcodedRating: rating)
            }
        } catch {
            // 5. 에러 처리 (do-try-catch)
            if let moyaError = error as? MoyaError {
                self.errorMessage = "네트워크 오류: \(moyaError.localizedDescription)"
                print("Moya 에러 상세: \(moyaError)")
            } else if error is DecodingError {
                self.errorMessage = "데이터 디코딩 오류가 발생했습니다."
                print("디코딩 에러: \(error)")
            } else {
                self.errorMessage = "알 수 없는 오류: \(error.localizedDescription)"
            }
        }
    }
    
}

extension MoyaProvider {
    // withCheckedThrowingContinuation을 사용하여 클로저 기반 코드를 async/await로 래핑합니다.
    func requestAsync(_ target: Target) async throws -> Response {
        return try await withCheckedThrowingContinuation { continuation in
            // Moya의 오리지널 request 함수 호출
            self.request(target) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    // 에러 발생 시 MoyaError를 던집니다.
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}


