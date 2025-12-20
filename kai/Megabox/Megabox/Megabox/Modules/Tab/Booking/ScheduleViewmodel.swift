//
//  ScheduleViewModel.swift
//  Megabox
//
//  Created by Gemini
//

import Foundation
import Combine

//   UI 업데이트는 항상 Main 스레드에서
@MainActor
class ScheduleViewModel: ObservableObject {

    // MARK: - 1. Data Source (JSON -> Domain Model)
    @Published private(set) var allMovieSchedules: [Movie] = []
    
    // MARK: - 2. UI State (Input)
    @Published var selectedMovie: Movie? = nil
    @Published var selectedAreaNames: Set<String> = []
    @Published var selectedDate: Date? = nil

    // MARK: - 3. Derived State (Output)
    @Published private(set) var allAreaNames: [String] = []
    @Published private(set) var weekDates: [Date] = []
    
    //   4주차 과제 로직 (UI 활성화 플래그)
    @Published private(set) var canSelectTheater: Bool = false
    @Published private(set) var canSelectDate: Bool = false
    @Published private(set) var canShowShowtimes: Bool = false
    
    //   5주차 과제 로직 (필터링된 최종 결과물)
    //    Key: 지역명 (예: "강남"), Value: 해당 지역의 상영관 목록
    @Published private(set) var filteredAuditoriums: [String: [AuditoriumItem]] = [:]

    // MARK: - 4. Error Handling
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init
    init(calendar: Calendar = .current) {
        // 1주일 날짜 구성 (4주차 VM 로직)
        let today = calendar.startOfDay(for: Date())
        weekDates = (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: today) }
        selectedDate = weekDates.first // 오늘 날짜 기본 선택

        //   4주차 UI 활성화 로직 + 5주차 필터링 로직 통합
        setupFilteringPipeline()
    }

    // MARK: - 1. Data Loading (5주차 과제)
    func loadSchedules() {
        // 비동기로 JSON 로드
        Task(priority: .background) {
            do {
                // 1. JSON 파일 URL
                guard let url = Bundle.main.url(forResource: "MovieSchedule", withExtension: "json") else {
                    throw ScheduleError.fileNotFound
                }
                
                // 2. Data 로드
                let data = try Data(contentsOf: url)
                
                // 3. JSON 디코딩 (DTO)
                let decoder = JSONDecoder()
                let responseDTO = try decoder.decode(APIResponseDTO.self, from: data)
                
                // 4. DTO -> Domain Model (Mapper 사용)
                let domainModels = ScheduleMapper.map(dto: responseDTO)
                
                // 5. 고유한 지역명(극장) 목록 추출
                let areaNames = self.extractAreaNames(from: domainModels)
                
                // 6. ViewModel 프로퍼티에 저장 (Main 스레드)
                await MainActor.run {
                    self.allMovieSchedules = domainModels
                    self.allAreaNames = areaNames
                    
                    // (선택) 로드 후 첫 번째 영화 자동 선택
                    self.selectedMovie = domainModels.first
                }
                
            } catch {
                // 에러 처리
                let typedError = (error as? ScheduleError) ?? .decodingError(error)
                print("❌ Failed to load schedules: \(typedError.localizedDescription)")
                await MainActor.run {
                    self.errorMessage = typedError.localizedDescription
                }
            }
        }
    }
    
    /// 도메인 모델에서 고유한 지역명 목록을 추출합니다.
    private func extractAreaNames(from movies: [Movie]) -> [String] {
        let allAreas = movies
            .flatMap { $0.schedules } // 모든 날짜의 일정
            .flatMap { $0.areas }     // 모든 지역
            .map { $0.areaName }      // 모든 지역명
        
        // 중복 제거 및 정렬
        return Array(Set(allAreas)).sorted()
    }

    // MARK: - 2. Filtering Pipeline (4주차 + 5주차 통합)
    private func setupFilteringPipeline() {
        
        // --- 4주차 로직: UI 활성화 플래그 ---
        
        // A) 영화 선택 여부 → canSelectTheater
        $selectedMovie
            .map { $0 != nil }
            .removeDuplicates()
            .assign(to: &$canSelectTheater)

        // B) (영화 선택됨 && 극장 1개 이상 선택됨) → canSelectDate
        Publishers.CombineLatest(
            $selectedMovie.map { $0 != nil },
            $selectedAreaNames.map { !$0.isEmpty }
        )
        .map { $0 && $1 }
        .removeDuplicates()
        .assign(to: &$canSelectDate)

        // C) (영화 && 극장 && 날짜 선택됨) → canShowShowtimes
        let canShow = Publishers.CombineLatest3(
            $selectedMovie.map { $0 != nil },
            $selectedAreaNames.map { !$0.isEmpty },
            $selectedDate.map { $0 != nil }
        )
        .map { $0 && $1 && $2 }
        .removeDuplicates()
        
        canShow.assign(to: &$canShowShowtimes)

        // --- 5주차 로직: 실제 데이터 필터링 ---
        
        // 3가지 Input (영화, 지역, 날짜)이 바뀔 때마다 필터링 실행
        let inputs = Publishers.CombineLatest3($selectedMovie, $selectedAreaNames, $selectedDate)
        
        // 4. canShowShowtimes가 true일 때만 필터링 실행
        inputs
            .combineLatest(canShow)
            .filter { _, canShow in canShow == true } // true일 때만 통과
            .map { inputs, _ in inputs } // (movie, areas, date)만 전달
            .map { (movie, areaNames, date) -> [String: [AuditoriumItem]] in
                
                // 1. 선택된 영화, 날짜가 있어야 함
                guard let movie = movie, let date = date else {
                    return [:]
                }
                
                // 2. 선택된 날짜의 일정 찾기
                let cal = Calendar.current
                guard let dailySchedule = movie.schedules.first(where: {
                    cal.isDate($0.date, inSameDayAs: date)
                }) else {
                    return [:] // 해당 날짜에 상영 일정 없음
                }

                // 3. 선택된 지역들(areaNames)을 순회하며 [지역명: 상영관목록] 딕셔너리 생성
                var result: [String: [AuditoriumItem]] = [:]
                for areaName in areaNames {
                    let auditoriums = dailySchedule.areas
                        .first { $0.areaName == areaName }?
                        .auditoriums
                    
                    // nil이 아니면 딕셔너리에 추가
                    if let auditoriums = auditoriums {
                        result[areaName] = auditoriums
                    } else {
                        result[areaName] = [] // 해당 지역에 상영관 없음
                    }
                }
                return result
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$filteredAuditoriums)
    }

    // MARK: - 3. UI Helpers
    
    /// 극장(지역) 선택 토글
    func toggleArea(_ areaName: String) {
        if selectedAreaNames.contains(areaName) {
            selectedAreaNames.remove(areaName)
        } else {
            selectedAreaNames.insert(areaName)
        }
    }

    /// DatePill에서 '오늘' 표시에 사용
    func isToday(_ date: Date) -> Bool {
        Calendar.current.isDateInToday(date)
    }
    
    /// DatePill에서 선택 상태 비교에 사용 (날짜만 비교)
    func isSameDay(_ date1: Date?, _ date2: Date) -> Bool {
        guard let date1 = date1 else { return false }
        return Calendar.current.isDate(date1, inSameDayAs: date2)
    }
}

// MARK: - Custom Errors
enum ScheduleError: Error, LocalizedError {
    case fileNotFound
    case decodingError(Error)
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "MovieSchedule.json 파일을 찾을 수 없습니다."
        case .decodingError(let error):
            return "JSON 디코딩 실패: \(error.localizedDescription)"
        }
    }
}
