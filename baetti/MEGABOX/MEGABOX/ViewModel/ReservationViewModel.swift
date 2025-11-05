//
//  ReservationViewModel.swift
//  MEGABOX
//
//  Created by 박정환 on 10/8/25.
//

import Foundation
import Combine

/// 영화별 예매 화면의 상태/로직을 관리하는 ViewModel (Combine 기반)
final class ReservationViewModel: ObservableObject {
    // MARK: - Data Sources
    @Published var movies: [MovieModel] = [
        .init(title: "F1 더 무비", poster: "poster3", countAudience: "30만"),
        .init(title: "귀멸의 칼날", poster: "poster2", countAudience: "1"),
        .init(title: "어쩔 수가 없다", poster: "poster1", countAudience: "20만"),
        .init(title: "얼굴", poster: "poster4", countAudience: nil),
        .init(title: "모노노케 히메", poster: "poster5", countAudience: nil),
        .init(title: "보스", poster: "poster6", countAudience: nil),
        .init(title: "야당", poster: "poster7", countAudience: nil),
        .init(title: "THE ROSES", poster: "poster8", countAudience: nil)
    ]

    /// 영화 선택 (처음엔 미선택)
    @Published var selectedMovieIndex: Int? = nil

    /// 극장 선택 (복수 선택 가능)
    let theaters: [String] = ["강남", "홍대", "신촌"]
    @Published var selectedTheaters: Set<String> = []

    /// 날짜 선택 (오늘 포함 일주일)
    @Published var weekDays: [DayItem] = DayItem.thisWeek()
    @Published var selectedDay: DayItem? = nil

    // MARK: - Enablement (derived)
    @Published private(set) var isTheaterEnabled: Bool = false      // 영화 선택 후 활성화
    @Published private(set) var isDateEnabled: Bool = false         // 영화 + 극장 선택 후 활성화
    @Published private(set) var isShowtimeVisible: Bool = false     // 영화 + 극장 + 날짜 모두 선택 시 표시

    // 상영 시간표 (목업)
    struct Showtime: Identifiable, Hashable { let id = UUID(); let time: String; let seats: String }
    @Published private(set) var showtimes: [String: [Showtime]] = [:] // theater -> showtimes

    private var bag = Set<AnyCancellable>()

    // MARK: - Init
    init() {
        bindPipelines()
    }

    private func bindPipelines() {
        // 1) 영화가 선택되면 극장 버튼 활성화
        $selectedMovieIndex
            .map { $0 != nil }
            .removeDuplicates()
            .assign(to: &self.$isTheaterEnabled)

        // 2) 영화 + (하나 이상의) 극장 선택 → 날짜 활성화
        Publishers.CombineLatest(
            $selectedMovieIndex.map { $0 != nil },
            $selectedTheaters.map { !$0.isEmpty }
        )
        .map { $0 && $1 }
        .removeDuplicates()
        .assign(to: &self.$isDateEnabled)

        // 3) 영화 + 극장 + 날짜 모두 선택 시 상영정보 표시
        Publishers.CombineLatest3(
            $selectedMovieIndex.map { $0 != nil },
            $selectedTheaters.map { !$0.isEmpty },
            $selectedDay.map { $0 != nil }
        )
        .map { $0 && $1 && $2 }
        .removeDuplicates()
        .assign(to: &self.$isShowtimeVisible)

        // 4) 세 가지 모두 선택되면 상영 시간표 로드
        Publishers.CombineLatest3(
            $selectedMovieIndex.compactMap { $0 },
            $selectedTheaters.filter { !$0.isEmpty },
            $selectedDay.compactMap { $0 }
        )
        .flatMap { [weak self] _, theaters, _ -> AnyPublisher<[String: [Showtime]], Never> in
            guard let self else { return Just([:]).eraseToAnyPublisher() }
            let result = self.mockShowtimes(for: Array(theaters))
            // 약간의 지연을 줘서 비동기 느낌
            return Just(result)
                .delay(for: .milliseconds(150), scheduler: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
        .receive(on: DispatchQueue.main)
        .assign(to: &self.$showtimes)
    }

    // MARK: - Helpers
    var currentMovieTitle: String {
        guard let idx = selectedMovieIndex, movies.indices.contains(idx) else { return "영화를 선택하세요" }
        return movies[idx].title
    }

    // MARK: - Intents
    func selectMovie(at index: Int) { guard movies.indices.contains(index) else { return }; selectedMovieIndex = index }
    func toggleTheater(_ name: String) {
        guard theaters.contains(name) else { return }
        if selectedTheaters.contains(name) { selectedTheaters.remove(name) } else { selectedTheaters.insert(name) }
    }
    func selectTheater(_ name: String) { guard theaters.contains(name) else { return }; selectedTheaters = [name] }
    func selectDay(_ day: DayItem) { guard weekDays.contains(day) else { return }; selectedDay = day }

    // MARK: - Mock Data
    private func mockShowtimes(for theaters: [String]) -> [String: [Showtime]] {
        let times = ["09:30","12:00","14:45","16:50","19:20"]
        var dict: [String: [Showtime]] = [:]
        for t in theaters {
            dict[t] = times.map { Showtime(time: $0, seats: "75 / 116") }
        }
        return dict
    }
}
