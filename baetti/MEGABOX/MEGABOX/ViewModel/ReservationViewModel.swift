//
//  ReservationViewModel.swift
//  MEGABOX
//
//  Created by 박정환 on 10/8/25.
//

// 이 파일은 예약(예매) 화면의 상태를 관리하고, 영화/극장/날짜 선택에 따라 상영 시간을 제공합니다.

import Foundation
import Combine

final class ReservationViewModel: ObservableObject {
    // MARK: - 데이터 소스
    /// 화면 표시용 영화 목록 (JSON 로드 후 채워짐)
    @Published var movies: [MovieModel] = []
    
    /// JSON 파싱(DTO → Domain)으로 로드된 실제 도메인 영화 목록
    @Published var domainMovies: [Movie] = []

    /// 영화 선택 (처음엔 미선택)
    @Published var selectedMovieIndex: Int? = nil

    /// 도메인 JSON에서 가져오는 극장 목록
    @Published var theaters: [String] = []
    @Published var selectedTheaters: Set<String> = []

    /// 날짜 선택 (오늘 포함 일주일)
    @Published var weekDays: [DayItem] = DayItem.thisWeek()
    @Published var selectedDay: DayItem? = nil

    // MARK: - 활성화 상태
    @Published private(set) var isTheaterEnabled: Bool = false      // 영화 선택 후 활성화
    @Published private(set) var isDateEnabled: Bool = false         // 영화 + 극장 선택 후 활성화
    @Published private(set) var isShowtimeVisible: Bool = false     // 영화 + 극장 + 날짜 모두 선택 시 표시

    // 상영 시간표
    struct Showtime: Identifiable, Hashable { let id = UUID(); let time: String; let seats: String }
    @Published private(set) var showtimes: [String: [Showtime]] = [:] // theater -> showtimes

    private var bag = Set<AnyCancellable>()

    // MARK: - 초기화
    init() {
        bindPipelines()
        loadMovieSchedules()
    }

    // MARK: - Load JSON Schedules (DTO → Domain 변환)
    func loadMovieSchedules() {
        guard let url = Bundle.main.url(forResource: "MovieSchedule", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("❌ JSON 파일 로드 실패")
            return
        }

        do {
            let response = try JSONDecoder().decode(MovieResponseDTO.self, from: data)
            let domain = response.data.movies.map { $0.toDomain() }
            DispatchQueue.main.async {
                self.domainMovies = domain

                // JSON에서 로드된 영화들을 UI 모델로 변환
                self.movies = domain.map {
                    MovieModel(title: $0.title, poster: "poster1", countAudience: nil)
                }

                // 앱 시작 시 첫 영화 자동 선택
                if self.selectedMovieIndex == nil, !self.movies.isEmpty {
                    self.selectedMovieIndex = 0
                }

                // 도메인 스케줄 기반 극장 목록 로드
                self.refreshTheatersFromDomain()
            }
        } catch {
            print("❌ JSON 디코딩 실패:", error)
        }
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
            let result = self.showtimesFromDomain(for: Array(theaters))
            // 약간의 지연을 줘서 비동기 느낌
            return Just(result)
                .delay(for: .milliseconds(150), scheduler: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
        .receive(on: DispatchQueue.main)
        .assign(to: &self.$showtimes)
    }

    /// 도메인 스케줄에서 극장 목록 업데이트
    private func refreshTheatersFromDomain() {
        guard
            let movieIndex = selectedMovieIndex,
            movies.indices.contains(movieIndex),
            let domainMovie = domainMovies.first(where: { $0.title == movies[movieIndex].title })
        else {
            theaters = []
            selectedTheaters = []
            return
        }

        // 날짜가 선택되지 않았으면 전체 날짜 기준으로 모든 극장 리스트 수집
        let selectedDate = selectedDay?.date
        let schedules = selectedDate == nil ?
            domainMovie.schedules :                                // 날짜 없음 → 전체 스케줄
            domainMovie.schedules.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate!) } // 날짜 있음 → 해당 날짜만

        let allAreas = schedules.flatMap { $0.areas.map { $0.area } }
        let names = Array(Set(allAreas)).sorted()
        theaters = names

        selectedTheaters = selectedTheaters.intersection(names)
        if selectedTheaters.isEmpty, let first = names.first {
            selectedTheaters = [first]
        }
    }

    // MARK: - 헬퍼 함수
    var currentMovieTitle: String {
        guard let idx = selectedMovieIndex, movies.indices.contains(idx) else { return "영화를 선택하세요" }
        return movies[idx].title
    }

    // MARK: - 사용자 입력 처리
    func selectMovie(at index: Int) {
        guard movies.indices.contains(index) else { return }
        selectedMovieIndex = index
        selectedDay = nil // 날짜 초기화
        refreshTheatersFromDomain()
    }
    func toggleTheater(_ name: String) {
        guard theaters.contains(name) else { return }
        if selectedTheaters.contains(name) { selectedTheaters.remove(name) } else { selectedTheaters.insert(name) }
    }
    func selectTheater(_ name: String) { guard theaters.contains(name) else { return }; selectedTheaters = [name] }
    func selectDay(_ day: DayItem) { guard weekDays.contains(day) else { return }; selectedDay = day
        refreshTheatersFromDomain()
    }

    // MARK: - 목 데이터 (임시)
    private func mockShowtimes(for theaters: [String]) -> [String: [Showtime]] {
        var dict: [String: [Showtime]] = [:]

        // 선택된 영화와 날짜가 있는지 확인
        guard
            let movieIndex = selectedMovieIndex,
            movies.indices.contains(movieIndex),
            let selectedDay = selectedDay
        else { return dict }

        // 선택된 영화 제목으로 도메인 모델에서 매칭되는 영화 찾기
        guard let domainMovie = domainMovies.first(where: { $0.title == movies[movieIndex].title }) else {
            return dict
        }

        // 선택된 날짜에 해당하는 스케줄 찾기
        let schedule = domainMovie.schedules.first { Calendar.current.isDate($0.date, inSameDayAs: selectedDay.date) }

        // 극장별로 상영시간표 구성
        for theater in theaters {
            // 선택한 극장(지역)에 해당하는 상영 정보 찾기
            let area = schedule?.areas.first { $0.area == theater }
            // 상영관(items) 아래의 showtimes를 평탄화하여 View에서 쓰기 좋은 형태로 변환
            let showtimes = area?.items.flatMap { item in
                item.showtimes.map { st in
                    Showtime(time: st.start, seats: "\(st.available) / \(st.total)")
                }
            } ?? []
            dict[theater] = showtimes
        }

        return dict
    }

    // MARK: - Domain 기반 상영시간 생성
    private func showtimesFromDomain(for theaters: [String]) -> [String: [Showtime]] {
        var dict: [String: [Showtime]] = [:]

        guard
            let movieIndex = selectedMovieIndex,
            movies.indices.contains(movieIndex),
            let selectedDay = selectedDay
        else { return dict }

        guard let domainMovie = domainMovies.first(where: { $0.title == movies[movieIndex].title }) else {
            return dict
        }

        let schedule = domainMovie.schedules.first { Calendar.current.isDate($0.date, inSameDayAs: selectedDay.date) }

        for theater in theaters {
            let area = schedule?.areas.first { $0.area == theater }
            let showtimes = area?.items.flatMap { item in
                item.showtimes.map { st in
                    Showtime(time: st.start, seats: "\(st.available) / \(st.total)")
                }
            } ?? []
            dict[theater] = showtimes
        }

        return dict
    }
}
