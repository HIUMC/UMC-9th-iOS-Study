//
//  BookingViewModel.swift
//  Megabox
//
//  Created by 김지우 on 10/9/25.
//

import Foundation
import Combine


/// 예매 흐름(영화 → 극장 → 날짜 → 상영시간표)의 상태를 관리
final class BookingViewModel: ObservableObject {

    // MARK: - Input (사용자 선택)
    @Published var selectedMovie: BookingMovie? = nil
    @Published var selectedTheaters: Set<Theater> = []
    @Published var selectedDate: Date? = nil

    // MARK: - Derived state
    @Published private(set) var canSelectTheater: Bool = false
    @Published private(set) var canSelectDate: Bool = false
    @Published private(set) var canShowShowtimes: Bool = false

    // MARK: - Data Source (데모용)
    @Published private(set) var movies: [BookingMovie] = [
        .init(title: "어쩔수가없다",      posterAsset: "nootherchoice", ageBadge: "15"),
        .init(title: "극장판 귀멸의 칼날", posterAsset: "demonslayer",  ageBadge: "15"),
        .init(title: "F1 더 무비",        posterAsset: "f1",            ageBadge: "12"),
        .init(title: "어쩔수가없다2",     posterAsset: "nootherchoice", ageBadge: "15"),
        .init(title: "F1 더 무비2",       posterAsset: "f1",            ageBadge: "12"),
    ]

    /// 오늘 기준 1주일
    @Published private(set) var weekDates: [Date] = []

    /// 오늘만 상영표 제공(강남/홍대만 있음, 신촌 없음)
    private(set) var todaysShowtimes: [Theater : [ShowTime]] = [
        .gangnam: [
            .init(time: "10:20", screen: "1관", seatsLeft: 23),
            .init(time: "13:10", screen: "3관", seatsLeft: 11),
            .init(time: "18:40", screen: "5관", seatsLeft: 7)
        ],
        .hongdae: [
            .init(time: "09:50", screen: "2관", seatsLeft: 31),
            .init(time: "15:20", screen: "4관", seatsLeft: 2)
        ],
        .sinchon: []
    ]

    private var bag = Set<AnyCancellable>()

    // MARK: - Init
    init(calendar: Calendar = .current) {
        // 1주일 날짜 구성 + 오늘 선택
        let today = Date()
        weekDates = (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: today) }
        selectedDate = weekDates.first


        // A) 영화 선택 여부 → canSelectTheater
        $selectedMovie
            .map { $0 != nil }
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] canSelect in
                self?.canSelectTheater = canSelect
            }
            .store(in: &bag)

        // B) (영화 선택됨 && 극장 1개 이상 선택됨) → canSelectDate
        Publishers.CombineLatest(
            $selectedMovie.map { $0 != nil },
            $selectedTheaters.map { !$0.isEmpty }
        )
        .map { $0 && $1 }
        .removeDuplicates()
        .receive(on: DispatchQueue.main)
        .sink { [weak self] canSelect in
            self?.canSelectDate = canSelect
        }
        .store(in: &bag)

        // C) (영화 && 극장 && 날짜 선택됨) → canShowShowtimes
        Publishers.CombineLatest3(
            $selectedMovie.map { $0 != nil },
            $selectedTheaters.map { !$0.isEmpty },
            $selectedDate.map { $0 != nil }
        )
        .map { $0 && $1 && $2 }
        .removeDuplicates()
        .receive(on: DispatchQueue.main)
        .sink { [weak self] canShow in
            self?.canShowShowtimes = canShow
        }
        .store(in: &bag)
    }

    // MARK: - Helpers
    func isToday(_ date: Date) -> Bool {
        Calendar.current.isDateInToday(date)
    }

    func toggleTheater(_ theater: Theater) {
        if selectedTheaters.contains(theater) {
            selectedTheaters.remove(theater)
        } else {
            selectedTheaters.insert(theater)
        }
    }

    func showtimesForSelected(_ date: Date, theater: Theater) -> [ShowTime] {
        guard isToday(date) else { return [] } // 오늘만 데이터
        return todaysShowtimes[theater] ?? []
    }

    func dayLabel(for date: Date) -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "E"
        return df.string(from: date)
    }

    func monthDayString(_ date: Date) -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "M.d"
        return df.string(from: date)
    }

    func dayOnly(_ date: Date) -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "d"
        return df.string(from: date)
    }
}

