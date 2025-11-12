//
//  MovieViewModel.swift
//  MEGABOX
//
//  Created by 고석현 on 10/10/25.
//

import Foundation
import Combine
import SwiftUI

// MARK: - 영화 관련 상태를 전부 관리하는 뷰모델
// Combine을 사용해서 영화 선택 → 극장 선택 → 날짜 선택 → 상영시간 표시까지 순서대로 반응하도록 구성함
final class MovieViewModel: ObservableObject {
    
    private let movieService = MovieService.shared

    // MARK: - 영화 목록
    @Published var movies: [MovieModel] = []
    
    // MARK: - 사용자가 선택한 요소들
    @Published var pickedMovie: MovieModel? = nil             // 선택한 영화
    @Published var chosenTheaters: Set<Theater> = []          // 선택한 극장들
    @Published var pickedDate: Date? = nil                    // 선택한 날짜
    
    // MARK: - 내부 상태 (UI 제어용)
    @Published private(set) var weekDays: [Date] = []         // 오늘부터 7일
    @Published private(set) var isTheaterActive = false       // 영화 선택 후 → 극장 버튼 활성화
    @Published private(set) var isDateActive = false          // 영화+극장 선택 후 → 날짜 선택 활성화
    @Published private(set) var showtimeSchedule: [Theater: [Showtime]] = [:] // 상영정보 저장소
    @Published private(set) var canDisplayShowtimes = false   // 영화, 극장, 날짜 모두 선택 시 상영정보 표시
    
    // Combine 구독 저장소 (Publisher를 다시 저장하는 용도)
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - 초기화
    init() {
        setupBindings()    // 상태 변화 연결
        createWeekDates()  // 주간 날짜 초기화
        Task {
            await fetchNowPlayingMovies()
        }
    }
    
    @MainActor
    func fetchNowPlayingMovies() async {
        do {
            let response = try await movieService.fetchNowPlayingMoviesAsync()
            let domainMovies = response.toDomain()
            self.movies = domainMovies
            print("성공: \(domainMovies.count) 개")
        } catch {
            print("실패: \(error)")
        }
    }
    
    // MARK: - Combine 바인딩 설정
    // 상태가 바뀔 때마다 자동으로 다음 단계가 활성화되도록 구성함
    private func setupBindings() {
        
        // 1. 영화가 선택되면 극장 선택이 가능해짐
        $pickedMovie
            .map { $0 != nil }                // 영화가 nil이 아니면 true
            .assign(to: &$isTheaterActive)
        
        // 2. 영화 + 극장이 모두 선택되면 날짜 선택 가능
        Publishers.CombineLatest(
            $pickedMovie.map { $0 != nil },
            $chosenTheaters.map { !$0.isEmpty }
        )
        .map { $0 && $1 }                    // 둘 다 true일 때만 true
        .assign(to: &$isDateActive)
        
        // 3. 영화 + 극장 + 날짜 모두 선택되면 상영정보가 나타남
        Publishers.CombineLatest3($pickedMovie, $chosenTheaters, $pickedDate)
            .map { movie, theaters, date in
                movie != nil && !theaters.isEmpty && date != nil
            }
            .assign(to: &$canDisplayShowtimes)
        
        // 4. 세 가지 모두 선택되면 더미 상영정보를 불러옴
        Publishers.CombineLatest3(
            $pickedMovie.compactMap { $0 },       // nil 제거
            $chosenTheaters.filter { !$0.isEmpty },
            $pickedDate.compactMap { $0 }
        )
        .flatMap { movie, theaters, date in
            // 실제 API 대신 더미데이터를 반환하는 부분
            Just(Self.generateMockShowtimes(for: theaters))
                .eraseToAnyPublisher()
        }
        .receive(on: DispatchQueue.main)
        .assign(to: &$showtimeSchedule)
    }
    
    // MARK: - 이번 주 날짜 만들기
    // 오늘 기준으로 7일치 날짜를 계산함
    private func createWeekDates() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        weekDays = (0..<7).compactMap { offset in
            calendar.date(byAdding: .day, value: offset, to: today)
        }
    }
    
    // MARK: - 더미 상영정보 생성
    // 실제로는 서버 응답이 들어올 부분. 지금은 고정된 시간(12시, 15시, 18시)으로 생성함.
    private static func generateMockShowtimes(for theaters: Set<Theater>) -> [Theater: [Showtime]] {
        var result: [Theater: [Showtime]] = [:]
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        for theater in theaters {
            // 첫 번째 상영 더미데이터 (12:00 ~ 14:00)
            let firstStart = calendar.date(byAdding: .hour, value: 12, to: today)!
            let firstEnd = calendar.date(byAdding: .hour, value: 14, to: today)!
            let first = Showtime(
                theater: theater,
                screenName: "1관",
                format: "2D",
                start: firstStart,
                end: firstEnd,
                remaining: Int.random(in: 60...120),
                capacity: 120
            )

            // 두 번째 상영 더미 데이터 (15:00 ~ 17:00)
            let secondStart = calendar.date(byAdding: .hour, value: 15, to: today)!
            let secondEnd = calendar.date(byAdding: .hour, value: 17, to: today)!
            let second = Showtime(
                theater: theater,
                screenName: "2관",
                format: "IMAX",
                start: secondStart,
                end: secondEnd,
                remaining: Int.random(in: 40...110),
                capacity: 120
            )

            // 세 번째 상영 구라데이터 더미데이터  (18:00 ~ 20:00)
            let thirdStart = calendar.date(byAdding: .hour, value: 18, to: today)!
            let thirdEnd = calendar.date(byAdding: .hour, value: 20, to: today)!
            let third = Showtime(
                theater: theater,
                screenName: "3관",
                format: "4DX",
                start: thirdStart,
                end: thirdEnd,
                remaining: Int.random(in: 20...90),
                capacity: 120
            )

            result[theater] = [first, second, third]
        }
        return result
    }
}
