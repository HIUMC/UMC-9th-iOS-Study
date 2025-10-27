//
//  MovieInfoViewModel.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/27/25.
//

import Foundation
import Combine

class MovieInfoViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var movieInfo: TopDomainModel?
    @Published var errorMessage: String?
    
    func fetchInfos() async {
        isLoading = true
        
        // JSON 파일 읽기: Bundle.main.url
        guard let url = Bundle.main.url(forResource: "MovieSchedule", withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return }
        
        do {
            // JSON -> APIResponse
            let response = try JSONDecoder().decode(APIResponse.self, from: data)
            
            await MainActor.run {
                // APIResponse의 toDomain() 메서드 호출 -> movieInfo 프로퍼티에 저장
                self.movieInfo = response.toDomain()
                self.isLoading = false
            }
        } catch {
            print("Decoding error:", error)
        }
        
        /// ** 전체 흐름 **
        ///  fetchInfos 함수 호출 시 JSON --> APIResponse라는 DTO로 변환
        ///  APIResponse 의 toDomain() 함수를 호출하여 TopDomainModel로 변환
        ///  변환된 TopDomainModel 객체가 movieInfo 프로퍼티에 저장
    }
    
    func fetchShowtimes(movie: Movie, theater: Theater, date: Date) -> AnyPublisher<[SchedulesDomainModel], Error> {
        return Future<[SchedulesDomainModel], Error> { promise in
                
                // 실제 네트워크 통신을 흉내 내는 딜레이
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    
                    // 전체 데이터에서 조건에 맞는 데이터 필터링
                    let results = allShowtimes.filter { showtime in
                        return showtime.movieId == movie.id && showtime.theaterId == theater.id
                    }
                    
                    // 필터링된 결과를 반환
                    promise(.success(results))
                }
            }
            .eraseToAnyPublisher()
        }
}
