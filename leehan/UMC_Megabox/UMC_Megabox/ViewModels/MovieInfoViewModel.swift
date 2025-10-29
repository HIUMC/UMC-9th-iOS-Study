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
    
    func fetchItems(movie: Movie, theater: Theater, date: Date) -> AnyPublisher<[ItemsDomainModel], Error> {
        
        return Future<[ItemsDomainModel], Error> { promise in
                
                // 실제 네트워크 통신을 흉내 내는 딜레이
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    
                    guard let movieInfo = self.movieInfo else { return promise(.success([])) }
                    
                    // 원하는 조건에 맞는 무비들만 필터링해서 movies라는 배열로 저장
                    let movies = movieInfo.data.movies.filter { a in
                        return a.title == movie.id
                    }
                    
                    // 전달받은 Date 객체를 YYYY-MM-DD 형태의 문자열로 변환
                    let dateString = self.dateFormatter().string(from: date)
                    
                    // movies라는 배열에서 선택한 날짜만 필터링해서 schedules라는 배열로 저장
                    let schedules = movies[0].schedules.filter { a in
                        return a.date == dateString }
                    
                    // schedules라는 배열에서 선택한 영화관만 필터링해서 areas라는 배열로 저장
                    let areas = schedules[0].areas.filter { a in
                        return a.area == theater.name }
                    
                    var results = areas[0].items
                    
                    
                    // 필터링된 결과를 반환: items 배열 (상영관 이름, format, 상영 시간 들의 배열)
                    promise(.success(results))
                }
            }
            .eraseToAnyPublisher()
        }
    
    private func dateFormatter() -> DateFormatter {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                formatter.locale = Locale(identifier: "ko_KR") // 한국 시간 기준
                return formatter
            }
}
