//
//  MovieViewModel.swift
//  MegaBox
//
//  Created by 이서현 on 9/29/25.
//

import Foundation
import Combine
import SwiftUI



class MovieViewModel: ObservableObject {
    @Published var movies: [MovieModel] = []
    
    
    @Published var selectedMovie: MovieModel? = nil
    @Published var selectedTheaters: Set<Theater> = []
    @Published var selectedDate: Date? = nil
    
    @Published private(set) var week: [Date] = []                // 오늘 ~ 6일
    @Published private(set) var showTheater = false         // 영화 선택 후 활성화
    @Published private(set) var showDate = false            // 영화+극장 선택 후 활성화
    @Published private(set) var showtimes: [Theater: [Showtime]] = [:]
    @Published private(set) var isShowtimeVisible = false        // 세 가지 모두 선택 후 노출
    
    
    @Published private(set) var showtimesByMovie: [UUID: [Showtime]] = [:]
    
    private var bag = Set<AnyCancellable>()

    init() {
        Task { await fetchMovies() }
        movieSelect()
    }
    
    func fetchMovies() async {
        guard let url = Bundle.main.url(forResource: "MovieSchedule", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("json 파일 못 찾겠어요")
            return
        }
        do {
            let response = try JSONDecoder().decode(APIResponse.self, from: data)
            let groups = response.data.toDomain() ///MovieShowtimeGroup 생성 (영화별 상영데이터 묶음)
                    await MainActor.run {
                        self.movies = groups.map { $0.movie }
                        self.showtimesByMovie = Dictionary(uniqueKeysWithValues: groups.map { ($0.movie.id, $0.showtimes) })
                    }
        } catch {
            print("디코딩 에러 :", error)
        }
    }
    
    private func movieSelect() {
        // 1) 극장 버튼 활성화: 영화가 선택되면 true
        $selectedMovie
            .map { $0 != nil }
            .assign(to: &$showTheater)
        
        // 2) 날짜 선택 활성화: 영화 선택 + 극장 1개 이상 선택
        Publishers.CombineLatest($selectedMovie.map { $0 != nil },
                                 $selectedTheaters.map { !$0.isEmpty })
        .map { $0 && $1 }
        .assign(to: &$showDate)
        
        // 3) 상영정보 표시 조건 - 다 선택됨? 그럼 상영 정보 보여줘 (물론 데이터는 안 담겨서 아래 4) 가 있어야 함)
        Publishers.CombineLatest3( ///3개의 Publisher를 묶음 (영화+극장+날짜) -> 3개의 퍼블리셔 중 하나라도 값이 바뀔 때마다 최신 튜플 내보냄
            $selectedMovie,
            $selectedTheaters,
            $selectedDate
        )
        .map { movie, theaters, date in
            movie != nil && !theaters.isEmpty && date != nil /// 모두 선택되었을 때 true
        }
        .assign(to: &$isShowtimeVisible) /// map의 값이 곧바로 isShowtimeVisible로 바인딩됨. 세 조건이 충족되면 상영 정보 UI가 보이고, 하나라도 빠지면 숨겨짐
        
        // 4) 상영정보 가져오기 (세 가지 모두 선택되면 fetch) - 데이터가 있어도 3) 이 없으면 보여줄지 말지 제어가 안 됨
        Publishers.CombineLatest3(
            $selectedMovie.compactMap { $0 },
            $selectedTheaters.filter { !$0.isEmpty },
            $selectedDate.compactMap { $0 }
        )
        .map { [weak self] (movie: MovieModel, theaters: Set<Theater>, date: Date) -> [Theater: [Showtime]] in
            guard let self = self else { return [:] }
            return self.realShowtimes(for: movie, theaters: theaters, date: date)
        }
        .receive(on: DispatchQueue.main)
        .sink { [weak self] value in
            self?.showtimes = value
        }
        .store(in: &bag)
        
        
    }
    // MARK: - 실제 JSON 기반 상영정보 필터
    private func realShowtimes(for movie: MovieModel, theaters: Set<Theater>, date: Date) -> [Theater: [Showtime]] {
        print("영화 :", movie.title, showtimesByMovie[movie.id]?.count ?? 0, "회차 존재")
        var result: [Theater: [Showtime]] = [:]
        let calendar = Calendar.current

        guard let allShowtimes = showtimesByMovie[movie.id] else { return result }

        for theater in theaters {
            let filtered = allShowtimes.filter { /// 특정 극장 + 선택 날짜와 같은 날짜인 회차만 필터링
                $0.theater == theater &&
                calendar.isDate($0.start, inSameDayAs: date) // 날짜만!! 비교
            }
            if !filtered.isEmpty {
                result[theater] = filtered
            }
        }
        return result
    }
    
}
