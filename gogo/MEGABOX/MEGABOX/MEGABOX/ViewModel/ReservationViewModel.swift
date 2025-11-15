//
//  ReservationViewModel.swift
//  MEGABOX
//
//  Rewritten to be self-contained (no external DTO type name assumptions)
//

import Foundation
import Combine
import SwiftUI

// MARK: - DTO -> json 파일
//Codable 프로토콜 사용 -> Encodable,Decodable
// JSON 구조: { status, message, data: { movies: [...] } }
fileprivate struct RVMResponse: Codable {
    let status: String
    let message: String
    let data: RVMData
}
fileprivate struct RVMData: Codable {
    let movies: [RVMMovie]
}
fileprivate struct RVMMovie: Codable {
    let title: String
    let ageRating: String
    let schedules: [RVMSchedule]
}
fileprivate struct RVMSchedule: Codable {
    let date: String           // yyyy-MM-dd
    let areas: [RVMArea]
}
fileprivate struct RVMArea: Codable {
    let area: String           // ex) "강남", "홍대", "신촌"
    let items: [RVMItem]
}
fileprivate struct RVMItem: Codable {
    let auditorium: String     // ex) "1관"
    let format: String         // ex) "2D", "IMAX", "4DX"
    let showtimes: [RVMShowtime]
}
fileprivate struct RVMShowtime: Codable {
    let start: String          // "HH:mm"
    let end: String            // "HH:mm"
    let available: Int
    let total: Int
}

// MARK: - 날짜
fileprivate let ymdFormatter: DateFormatter = {
    let f = DateFormatter()
    f.calendar = Calendar(identifier: .gregorian)
    f.locale = Locale(identifier: "ko_KR_POSIX")
    f.timeZone = TimeZone(secondsFromGMT: 0)
    f.dateFormat = "yyyy-MM-dd"
    return f
}()
fileprivate let hmFormatter: DateFormatter = {
    let f = DateFormatter()
    f.calendar = Calendar(identifier: .gregorian)
    f.locale = Locale(identifier: "ko_KR_POSIX")
    f.timeZone = TimeZone(secondsFromGMT: 0)
    f.dateFormat = "HH:mm"
    return f
}()

final class ReservationViewModel: ObservableObject {

    // MARK: - Domain 데이터 (View에서 직접 쓰는 상태)
    @Published var movies: [MovieModel] = []                 // 포스터/타이틀 등 표시용
    @Published var pickedMovie: MovieModel? = nil            // 선택한 영화
    @Published var chosenTheaters: Set<Theater> = []         // 선택한 극장들
    @Published var pickedDate: Date? = nil                   // 선택한 날짜

    // UI
    @Published private(set) var weekDays: [Date] = []
    @Published private(set) var isTheaterActive: Bool = false
    @Published private(set) var isDateActive: Bool = false
    @Published private(set) var canDisplayShowtimes: Bool = false

    // 극장별 상영정보 (뷰에서 그대로 렌더)
    @Published private(set) var showtimeSchedule: [Theater: [Showtime]] = [:]

    // MARK: - JSON 디코딩 관련
    private var rvmMovies: [RVMMovie] = []              // JSON 디코딩 결과(원본)
    private var cancellables = Set<AnyCancellable>()

    // MARK: - 시작 초기화
    init() {
        setupBindings()
        createWeekDates()
        fetchMovies()
    }
}

// MARK: - 매핑
extension ReservationViewModel {
    /// 로컬 JSON(MovieSchedule.json) 로드 → DTO  → Domain 변환
    func fetchMovies() {
        DispatchQueue.global(qos: .background).async {
            guard let url = Bundle.main.url(forResource: "MovieSchedule", withExtension: "json") else {
                print("❌ MovieSchedule.json not found. Check Target Membership!")
                return
            }
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase

                // 실제 JSON 구조: { status, message, data: { movies: [...] } }
                let api = try decoder.decode(RVMResponse.self, from: data)
                let decodedMovies = api.data.movies

                DispatchQueue.main.async {
                    self.rvmMovies = decodedMovies

                    // 포스터는 JSON 순서대로 poster1~poster8 매핑
                    let posters = ["poster1","poster2","poster3","poster4","poster5","poster6","poster7","poster8"]
                    self.movies = decodedMovies.enumerated().map { idx, dto in
                        let posterName = posters.indices.contains(idx) ? posters[idx] : "poster1"
                        return MovieModel(
                            title: dto.title,
                            poster: posterName,
                            countAudience: nil,
                            description: nil,
                            releaseDate: nil,
                            rating: dto.ageRating,
                            backdrop: nil
                        )
                    }
                }
            } catch {
                print("❌ JSON Decoding Failed:", error)
            }
        }
    }
}

extension ReservationViewModel {
    /// JSON과 동일한 날짜 범위를 만들기 위해 오늘을 2025-09-22로 고정
    private func createWeekDates() {
        let base = ymdFormatter.date(from: "2025-09-22") ?? Date()
        let cal = Calendar.current
        let start = cal.startOfDay(for: base)
        weekDays = (0..<7).compactMap { cal.date(byAdding: .day, value: $0, to: start) }
    }
}


extension ReservationViewModel {
    private func setupBindings() {
        // 영화가 선택되면 극장 선택 활성화
        $pickedMovie
            .map { $0 != nil }
            .assign(to: &$isTheaterActive)

        // 영화 + 극장 선택되면 날짜 선택 활성화
        Publishers.CombineLatest(
            $pickedMovie.map { $0 != nil },
            $chosenTheaters.map { !$0.isEmpty }
        )
        .map { $0 && $1 }
        .assign(to: &$isDateActive)

        // 영화 + 극장 + 날짜 모두 선택되면 상영정보 표시 가능
        Publishers.CombineLatest3($pickedMovie, $chosenTheaters, $pickedDate)
            .map { m, t, d in m != nil && !t.isEmpty && d != nil }
            .assign(to: &$canDisplayShowtimes)

        // 세 조건이 모두 만족되면 실제 상영정보 생성
        Publishers.CombineLatest3(
            $pickedMovie.compactMap { $0 },
            $chosenTheaters.filter { !$0.isEmpty },
            $pickedDate.compactMap { $0 }
        )
        .map { movie, theaters, date in
            self.generateShowtimes(for: movie, theaters: theaters, on: date)
        }
        .assign(to: &$showtimeSchedule)
    }
}

// MARK: - Showtime Mapping
extension ReservationViewModel {
    /// 선택된 영화/극장/날짜에 맞춰 상영정보 사전을 생성
    private func generateShowtimes(for movie: MovieModel, theaters: Set<Theater>, on date: Date) -> [Theater: [Showtime]] {
        // 1) 선택 영화의 원본 DTO 찾기
        guard let dto = rvmMovies.first(where: { $0.title == movie.title }) else { return [:] }

        // 2) 날짜 매칭 (yyyy-MM-dd 고정)
        let target = ymdFormatter.string(from: date)
        guard let schedule = dto.schedules.first(where: { $0.date == target }) else { return [:] }

        // 3) DTO → Domain 매핑 (Theater : [Showtime])
        var result: [Theater: [Showtime]] = [:]
        let cal = Calendar.current
        for area in schedule.areas {
            guard let theater = Theater(rawValue: area.area) else { continue }
            var shows: [Showtime] = []
            for item in area.items {
                for st in item.showtimes {
                    // 날짜 + 시각 합치기 (동일한 day 기준)
                    guard let day = ymdFormatter.date(from: target),
                          let startTime = hmFormatter.date(from: st.start),
                          let endTime = hmFormatter.date(from: st.end) else { continue }

                    let start = cal.date(bySettingHour: cal.component(.hour, from: startTime),
                                         minute: cal.component(.minute, from: startTime),
                                         second: 0, of: day) ?? day
                    let end = cal.date(bySettingHour: cal.component(.hour, from: endTime),
                                       minute: cal.component(.minute, from: endTime),
                                       second: 0, of: day) ?? day

                    shows.append(Showtime(
                        theater: theater,
                        screenName: item.auditorium,
                        format: item.format,
                        start: start,
                        end: end,
                        remaining: st.available,
                        capacity: st.total
                    ))
                }
            }
            // 시간 오름차순 정렬
            shows.sort { $0.start < $1.start }
            result[theater] = shows
        }
        return result.filter { theaters.contains($0.key) }
    }
}
