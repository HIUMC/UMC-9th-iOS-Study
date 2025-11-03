//
//  ScheduleViewModel.swift
//  MEGABOX
//
//  Created by 정승윤 on 10/26/25.
//

import Foundation
import SwiftUI

class ScheduleViewModel: ObservableObject {
    @Published var schedule: ScheduleModel?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var currentShowtimes: [TimeModel] = []
    
    func fetchSchedule() async {
        isLoading = true
        
        guard let url = Bundle.main.url(
            forResource: "MovieSchedule", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            
            errorMessage = "JSON 파일 없음"
            isLoading = false
            return
        }
        
        do {
            let decoder = JSONDecoder()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            
            decoder.dateDecodingStrategy = .custom({ decoder in
                let container = try decoder.singleValueContainer()
                let dateString = try container.decode(String.self)
                
                // 정의한 dateFormatter를 사용하여 문자열을 Date로 변환 시도
                if let date = dateFormatter.date(from: dateString) {
                    return date
                }
                
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Invalid date format: \(dateString). Expected 'yyyy-MM-dd'."
                )
            })
            
            let response = try decoder.decode(ScheduleDTO.self, from: data)
            self.schedule = response.toDomain()
        } catch {
            errorMessage = "Decoding error: \(error)"
        }
        
        isLoading = false
    }
    
    private func filteredShowtimes (
        for movie: MovieModel?,
        selectedDate: Date?,
        selectedTheaters: [String]) -> [TimeModel] {
            
            guard let schedule = self.schedule,
                  let movie = movie,
                  let selectedDate = selectedDate,
                  !selectedTheaters.isEmpty else {
                print("필수 데이터 누락")
                return[]
            }
            
            guard let scheduledMovie = schedule.data.movies.first(where: {
                let jsonTitle = $0.title.lowercased()
                let selectedTitle = movie.name.lowercased()
                return jsonTitle == selectedTitle
            }) else {
                
                print("DEBUG: 영화 제목 불일치. JSON에 해당 영화 없음: \(movie.name)")
                return []
            }
            
            // 1. 날짜
            let filteredByDate = scheduledMovie.schedules.filter { dateModel in
                return Calendar.current.isDate(dateModel.date, inSameDayAs: selectedDate)
            }
            
            if filteredByDate.isEmpty {
                print("DEBUG FILTER: 2단계 실패 - 날짜 불일치. 선택 날짜: \(selectedDate)")
                // JSON에 있는 모든 날짜 로그로 출력
                let availableDates = scheduledMovie.schedules.map { $0.date.formatted(.dateTime.day().month()) }
                print("DEBUG FILTER: JSON 내 상영 가능 날짜: \(availableDates)")
                return []
            }
            
            // 2. 극장
            var filteredByTheater: [AreaModel] = []
            
            for dateSchedule in filteredByDate {
                let matchingAreas = dateSchedule.areas.filter { area in
                    let areaName = area.area.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    return selectedTheaters.contains(where: {
                        $0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == areaName
                    })
                }
                filteredByTheater.append(contentsOf: matchingAreas)
            }
            
            if filteredByTheater.isEmpty {
                print("DEBUG FILTER: 3단계 실패 - 극장 불일치. 선택 극장: \(selectedTheaters)")
                // JSON에 있는 모든 극장 로그로 출력 (첫 번째 날짜 스케줄에서만)
                if let firstDate = filteredByDate.first {
                    let availableTheaters = firstDate.areas.map { $0.area }
                    print("DEBUG FILTER: JSON 내 상영 가능 극장: \(availableTheaters)")
                }
                return []
            }
            
            // 3. TimeModel
            var showtimes: [TimeModel] = []
            for area in filteredByTheater {
                showtimes.append(contentsOf: area.items)
            }
            if showtimes.isEmpty {
                print("DEBUG FILTER: 4단계 실패 - TimeModel은 있으나 내부 showtimes가 비어있음.")
            }
            
            return showtimes
        }
    
    public func applyFilterAndUpdateState(
        movie: MovieModel?,
        date: Date?,
        theaters: [String]
    ) {
        let filtered = self.filteredShowtimes(
            for: movie,
            selectedDate: date,
            selectedTheaters: theaters
        )
        
        // @Published 변수인 currentShowtimes를 업데이트
        // 이는 MovieBookView의 TheaterInfoView에 반영됩니다.
        self.currentShowtimes = filtered
        
        // 디버깅 로그 (선택 사항)
        print("=== ScheduleViewModel Updated ===")
        print("Filtered Showtimes Count: \(filtered.count)")
        for tm in filtered {
            print("  - \(tm.auditorium): \(tm.showtimes.count) times")
        }
        print("================================")
    }
}
// MainActor 공부해보고 써보기
