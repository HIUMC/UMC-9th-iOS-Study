//
//  toDomain.swift
//  MegaBox
//
//  Created by 이서현 on 10/29/25.
//

import Foundation
import SwiftUI

// MARK: - Extension

///MovieData → MovieModel 매핑
extension MovieData {
    func toDomain() -> MovieModel {
        return MovieModel(
            title: title,
            poster: "poster1", /// 이 부분은 어떻게 하면 좋을까요?
            countAudience: nil
        )
    }
}


/// MovieScheduleAreaDTO → [Showtime] 매핑
extension MovieScheduleAreaDTO {
    func toDomain(theater: Theater, scheduleDate: String) -> [Showtime] {
        var showtimes: [Showtime] = []
        let formatter = DateFormatter() ///날짜 문자열
        formatter.dateFormat = "yyyy-MM-dd HH:mm"

        for item in items { /// area 안에는 여러 auditorium 존재
            for st in item.showtimes { ///각 상영관마다 여러 상영시간(시작/끝, 잔여좌석 ...) 존재
                // "2025-11-01" + "11:30" → "2025-11-01 11:30"
                let startString = "\(scheduleDate) \(st.start)"
                let endString = "\(scheduleDate) \(st.end)"
                let startDate = formatter.date(from: startString) ?? Date() ///문자열 → Date 파싱, 실패하면 현재 날짜로..
                let endDate = formatter.date(from: endString) ?? Date()

                showtimes.append( ///도메인 모델로 묶어서 배열에 추가함
                    Showtime(
                        theater: theater,
                        screenName: item.auditorium,
                        format: item.format, ///2D, 3D, IMAX 등
                        start: startDate,
                        end: endDate,
                        remaining: st.available,
                        capacity: st.total
                    )
                )
            }
        }
        return showtimes
    }
}

///MovieDataContainer → [MovieShowtimeGroup] 매핑
extension MovieDataContainer {
    func toDomain() -> [MovieShowtimeGroup] {
        var result: [MovieShowtimeGroup] = [] ///영화별 상영 정보 묶음 정보 담는 배열

        for movieData in movies { ///api 응답에 있는 모든 영화 순회하기
            let movie = movieData.toDomain() ///MovieData → MovieModel 매핑 구조 재사용

            var allShowtimes: [Showtime] = [] // 상영시간표들 모아놓은 배열
            for schedule in movieData.schedules { ///같은 영화 내 상영 스케줄
                for area in schedule.areas { /// 같은 영화 내 같은 스케줄 내 다른 지역
                    if let theater = Theater(rawValue: area.area) { /// Theater enum값과 같다면 값 대입 (강남 홍대 신촌)
                        allShowtimes += area.toDomain(theater: theater, scheduleDate: schedule.date)
                        /// MovieScheduleAreaDTO → [Showtime] 매핑
                    }
                }
            }

            result.append(MovieShowtimeGroup(movie: movie, showtimes: allShowtimes))
        }

        return result
    }
}
