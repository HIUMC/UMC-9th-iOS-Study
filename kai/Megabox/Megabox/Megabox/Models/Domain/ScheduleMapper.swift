//
//  ScheduleMapper.swift
//  Megabox
//
//  Created by 김지우 on 10/30/25.
//

import Foundation

// DTO 객체를 Domain Model 객체로 변환(map)하는 역할만 담당합니다.
struct ScheduleMapper {
    
    // 날짜 문자열("yyyy-MM-dd")을 Date로 변환하기 위한 Formatter
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(secondsFromGMT: 0) // UTC 기준
        return formatter
    }()
    
    // 시간 문자열("HH:mm")과 날짜(Date)를 조합해 최종 Date로 변환하는 헬퍼
    private static func combine(date: Date, timeString: String) -> Date? {
        let timeComponents = timeString.split(separator: ":").compactMap { Int($0) }
        if timeComponents.count == 2 {
            return Calendar.current.date(bySettingHour: timeComponents[0],
                                         minute: timeComponents[1],
                                         second: 0,
                                         of: date)
        }
        return nil
    }
    
    // --- 매핑 함수들 ---

    // [ShowtimeDTO] -> [Showtime]
    //  중요: 상위의 날짜(date) 정보가 반드시 필요합니다.
    static func mapShowtimes(_ dtos: [ShowtimeDTO], on date: Date) -> [Showtime] {
        return dtos.compactMap { dto in
            // "11:30" -> 2025-09-22 11:30:00 (Date)
            guard let startTime = combine(date: date, timeString: dto.start),
                  let endTime = combine(date: date, timeString: dto.end) else {
                print("Warning: Failed to parse showtime: \(dto.start)")
                return nil
            }
            
            return Showtime(start: startTime,
                            end: endTime,
                            available: dto.available,
                            total: dto.total)
        }
    }
    
    // [AuditoriumItemDTO] -> [AuditoriumItem]
    static func mapAuditoriums(_ dtos: [AuditoriumItemDTO], on date: Date) -> [AuditoriumItem] {
        return dtos.map { dto in
            AuditoriumItem(
                name: dto.auditorium,
                format: dto.format,
                // 하위 Showtimes 매핑 (날짜 정보 전달)
                showtimes: mapShowtimes(dto.showtimes, on: date)
            )
        }
    }
    
    // [AreaDTO] -> [AreaSchedule]
    static func mapAreas(_ dtos: [AreaDTO], on date: Date) -> [AreaSchedule] {
        return dtos.map { dto in
            AreaSchedule(
                areaName: dto.area,
                // 하위 Auditoriums 매핑 (날짜 정보 전달)
                auditoriums: mapAuditoriums(dto.items, on: date)
            )
        }
    }
    
    // [DailyScheduleDTO] -> [DailyMovieSchedule]
    static func mapDailySchedules(_ dtos: [DailyScheduleDTO]) -> [DailyMovieSchedule] {
        return dtos.compactMap { dto in
            // "2025-09-22" -> Date 객체
            guard let date = dateFormatter.date(from: dto.date) else {
                print("Warning: Failed to parse date string: \(dto.date)")
                return nil
            }
            
            return DailyMovieSchedule(
                date: date,
                // 하위 Areas 매핑 (방금 변환한 Date 객체 전달)
                areas: mapAreas(dto.areas, on: date)
            )
        }
    }
    
    // [MovieDTO] -> [Movie] (최종 진입점)
    static func mapMovies(_ dtos: [MovieDTO]) -> [Movie] {
            
            // ID와 포스터 에셋 이름을 매핑하는 딕셔너리 추가
            // (MovieSearchSheet의 Preview 샘플을 기반으로 작성)
            let posterMap: [String: String] = [
                "m-001": "nootherchoice",
                "m-002": "f1",
                "m-003": "demonslayer"
            ]
            
            return dtos.map { dto in
                
                //ID에 해당하는 포스터 이름을 찾음
                let assetName = posterMap[dto.id]
                
                return Movie(
                    id: dto.id,
                    title: dto.title,
                    ageRating: dto.age_rating,
                    // 하위 DailySchedules 매핑
                    schedules: mapDailySchedules(dto.schedules),
                    
                    //포스터 이름 전달
                    posterAsset: assetName!
                )
            }
        }
    
    // APIResponseDTO -> [Movie]
    // ViewModel이 최종적으로 호출할 함수입니다.
    static func map(dto: APIResponseDTO) -> [Movie] {
        return mapMovies(dto.data.movies)
    }
}
