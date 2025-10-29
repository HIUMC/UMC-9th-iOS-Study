//
//  MovieService.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/6/25.
//
/*
import SwiftUI
import Foundation
import Combine

struct MovieService {
    private var allShowtimes: [Showtime] = [
        
                // --- "F1" (movie01) 상영 정보 ---
                // 강남
                .init(id: "s001", movieId: "F1", theaterId: "강남", time: "09:30", totalSeats: 150, availableSeats: 80),
                .init(id: "s002", movieId: "F1", theaterId: "강남", time: "12:00", totalSeats: 150, availableSeats: 25),
                .init(id: "s003", movieId: "F1", theaterId: "강남", time: "17:45", totalSeats: 150, availableSeats: 140),
                // 홍대
                .init(id: "s004", movieId: "F1", theaterId: "홍대", time: "11:00", totalSeats: 120, availableSeats: 5),
                .init(id: "s005", movieId: "F1", theaterId: "홍대", time: "19:00", totalSeats: 120, availableSeats: 77),

                // --- "무한성" (movie02) 상영 정보 ---
                // 강남
                .init(id: "s006", movieId: "무한성", theaterId: "강남", time: "10:00", totalSeats: 150, availableSeats: 150),
                .init(id: "s007", movieId: "무한성", theaterId: "강남", time: "15:20", totalSeats: 150, availableSeats: 60),
                // 홍대
                .init(id: "s008", movieId: "무한성", theaterId: "홍대", time: "13:10", totalSeats: 120, availableSeats: 110),
                
                // --- "어쩔수가없다" (movie03) 상영 정보 ---
                // 홍대
                .init(id: "s009", movieId: "어쩔수가없다", theaterId: "홍대", time: "10:30", totalSeats: 100, availableSeats: 80),
                .init(id: "s010", movieId: "어쩔수가없다", theaterId: "홍대", time: "13:00", totalSeats: 100, availableSeats: 0),
                .init(id: "s011", movieId: "어쩔수가없다", theaterId: "홍대", time: "22:00", totalSeats: 100, availableSeats: 95),

                // --- "얼굴" (movie04) 상영 정보 ---
                // 강남
                .init(id: "s012", movieId: "얼굴", theaterId: "강남", time: "14:00", totalSeats: 150, availableSeats: 101),
                
                // --- "모노노케히메" (movie05) 상영 정보 ---
                // 홍대
                .init(id: "s013", movieId: "모노노케히메", theaterId: "홍대", time: "16:30", totalSeats: 120, availableSeats: 44)
                
                // "신촌" 상영 x
            ]
    
    func fetchShowtimes(movie: Movie, theater: Theater, date: Date) -> AnyPublisher<[Showtime], Error> {
            return Future<[Showtime], Error> { promise in
                
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

*/
