//
//  MovieViewModel.swift
//  MegaBox
//
//  Created by 박병선 on 10/9/25.
//
import Foundation
import Combine
import SwiftUI

class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = [
        .init(title: "F1 더 무비", poster: "f1_poster", audience: "30만"),
        .init(title: "귀멸의 칼날", poster: "demonSlayer_poster", audience: "1"),
        .init(title: "어쩔 수가 없다", poster: "noOtherChoice_poster", audience: "20만"),
        .init(title: "얼굴", poster: "face_poster", audience: nil),
        .init(title: "모노노케 히메", poster: "mono_poster", audience: nil),
        .init(title: "보스", poster: "boss_poster", audience: nil),
        .init(title: "야당", poster: "yadang_poster", audience: nil),
        .init(title: "THE ROSES", poster: "theRoses_poster", audience: nil)
    ]


    @Published var selectedMovie: Movie? = nil //사용자가 선택한 영화
    @Published var selectedTheaters: Set<Theater> = [] //선택한 극장 집합
    @Published var selectedDate: Date? = nil //선택된 날짜

    @Published private(set) var week: [Date] = []                // 오늘부터 6일 후까지의 날짜
    @Published private(set) var showTheater = false         // 영화 선택시
    @Published private(set) var showDate = false            // 영화+극장 선택 후 활성화
    @Published private(set) var showtimes: [Theater: [Showtime]] = [:]
    @Published private(set) var isShowtimeVisible = false        // 세 가지 모두 선택 후 노출

    private var bag = Set<AnyCancellable>()

    init() { movieSelect() }

    private func movieSelect() {
        //  극장 버튼 활성화: 영화가 선택되면 true
        $selectedMovie
            .map { $0 != nil }
            .assign(to: &$showTheater)

        // 날짜 선택 활성화: 영화 선택 + 극장 1개 이상 선택
        Publishers.CombineLatest($selectedMovie.map { $0 != nil },
                                 $selectedTheaters.map { !$0.isEmpty })
        .map { $0 && $1 }
        .assign(to: &$showDate)

        //  상영정보 표시 조건
        Publishers.CombineLatest3( ///3개의 Publisher를 묶음 (영화+극장+날짜)
            $selectedMovie,
            $selectedTheaters,
            $selectedDate
        )
        .map { movie, theaters, date in
            movie != nil && !theaters.isEmpty && date != nil
        }
        .assign(to: &$isShowtimeVisible)

        //  상영정보 가져오기 (세 가지 모두 선택되면 fetch)
        Publishers.CombineLatest3(
            $selectedMovie.compactMap { $0 },
            $selectedTheaters.filter { !$0.isEmpty },
            $selectedDate.compactMap { $0 }
        )
        .flatMap { movie, theaters, date in
            // 단순 mock 데이터 반환
            Just(Self.mockShowtimes(for: theaters)).eraseToAnyPublisher()
        }
        .receive(on: DispatchQueue.main)
        .assign(to: &$showtimes)


    }
    // MARK: - 더미데이터 상영정보
    private static func mockShowtimes(for theaters: Set<Theater>) -> [Theater: [Showtime]] {
        var result: [Theater: [Showtime]] = [:]
        let now = Date()
        let cal = Calendar.current

        for t in theaters {
            let first = Showtime(
                theater: t,
                screenName: "1관",
                format: "2D",
                start: now,
                end: cal.date(byAdding: .minute, value: 120, to: now)!,
                remaining: 100,
                capacity: 120
            )
            let second = Showtime(
                theater: t,
                screenName: "2관",
                format: "IMAX",
                start: cal.date(byAdding: .hour, value: 3, to: now)!,
                end: cal.date(byAdding: .hour, value: 5, to: now)!,
                remaining: 70,
                capacity: 120
            )
            result[t] = [first, second]
        }
        return result
    }

}
