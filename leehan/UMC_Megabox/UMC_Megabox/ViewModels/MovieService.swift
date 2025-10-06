//
//  MovieService.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/6/25.
//

import Foundation
import Combine

struct MovieService {
    private var allShowtimes: [Showtime] = [
        
                // --- "F1" (movie01) 상영 정보 ---
                // 강남
                .init(id: "s001", movieId: "movie01", theaterId: "theater01", time: "09:30", totalSeats: 150, availableSeats: 80),
                .init(id: "s002", movieId: "movie01", theaterId: "theater01", time: "12:00", totalSeats: 150, availableSeats: 25),
                .init(id: "s003", movieId: "movie01", theaterId: "theater01", time: "17:45", totalSeats: 150, availableSeats: 140),
                // 홍대
                .init(id: "s004", movieId: "movie01", theaterId: "theater02", time: "11:00", totalSeats: 120, availableSeats: 5),
                .init(id: "s005", movieId: "movie01", theaterId: "theater02", time: "19:00", totalSeats: 120, availableSeats: 77),

                // --- "무한성" (movie02) 상영 정보 ---
                // 강남
                .init(id: "s006", movieId: "movie02", theaterId: "theater01", time: "10:00", totalSeats: 150, availableSeats: 150),
                .init(id: "s007", movieId: "movie02", theaterId: "theater01", time: "15:20", totalSeats: 150, availableSeats: 60),
                // 홍대
                .init(id: "s008", movieId: "movie02", theaterId: "theater02", time: "13:10", totalSeats: 120, availableSeats: 110),
                
                // --- "어쩔수가없다" (movie03) 상영 정보 ---
                // 홍대
                .init(id: "s009", movieId: "movie03", theaterId: "theater02", time: "10:30", totalSeats: 100, availableSeats: 80),
                .init(id: "s010", movieId: "movie03", theaterId: "theater02", time: "13:00", totalSeats: 100, availableSeats: 0),
                .init(id: "s011", movieId: "movie03", theaterId: "theater02", time: "22:00", totalSeats: 100, availableSeats: 95),

                // --- "얼굴" (movie04) 상영 정보 ---
                // 강남
                .init(id: "s012", movieId: "movie04", theaterId: "theater01", time: "14:00", totalSeats: 150, availableSeats: 101),
                
                // --- "모노노케히메" (movie05) 상영 정보 ---
                // 홍대
                .init(id: "s013", movieId: "movie05", theaterId: "theater02", time: "16:30", totalSeats: 120, availableSeats: 44)
                
                // "신촌" 상영 x
            ]
    
    func fetchShowtimes(movie: Movie, theater: Theater, date: Date) -> AnyPublisher<[Showtime], Error> {
            return Future<[Showtime], Error> { promise in
                
                // 실제 네트워크 통신을 흉내 내는 딜레이
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    
                    // ✅ 핵심 로직: 전체 데이터에서 조건에 맞는 데이터를 '필터링'
                    let results = allShowtimes.filter { showtime in
                        return showtime.movieId == movie.id && showtime.theaterId == theater.id
                    }
                    
                    // 필터링된 결과를 성공적으로 반환
                    promise(.success(results))
                }
            }
            .eraseToAnyPublisher()
        }
}

