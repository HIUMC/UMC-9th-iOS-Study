//
//  MovieViewModel.swift
//  MegaBox
//
//  Created by 박병선 on 10/9/25.
//
import Foundation
import Combine


@MainActor
final class MovieViewModel: ObservableObject {

    // 포스터 가로 스크롤용(초기 더미 — JSON 로딩 후 덮어씌워짐)
    @Published var movies: [Movie] = [
        .init(title: "F1 더 무비", poster: "f1_poster", audience: "30만"),
        .init(title: "귀멸의 칼날", poster: "demonSlayer_poster", audience: "1"),
        .init(title: "어쩔수가없다", poster: "noOtherChoice_poster", audience: "20만"),
        .init(title: "얼굴", poster: "face_poster", audience: nil),
        .init(title: "모노노케 히메", poster: "mono_poster", audience: nil),
        .init(title: "보스", poster: "boss_poster", audience: nil),
        .init(title: "야당", poster: "yadang_poster", audience: nil),
        .init(title: "THE ROSES", poster: "theRoses_poster", audience: nil)
    ]
    
      /// 홈 리스트에 보여줄 영화들
      @Published var nowPlayingMovies: [Movie] = []
    
      /// 선택된 영화의 상세 정보
      @Published var selectedMovieDetail: MovieDetail?
      
      /// 로딩 상태
      @Published var isLoading: Bool = false
      
      /// 에러 메시지 (필요 시 Alert 등에 사용)
      @Published var errorMessage: String?
      
      // MARK: - Dependencies
      
      private let tmdbService: TMDBServicing
      
      /// 상세를 만들 때 원본 DTO가 필요하므로 캐싱해 둠
      private var nowPlayingDTOs: [PlayingMovieDTO] = []
      
      // MARK: - Init
      
      init(tmdbService: TMDBServicing = TMDBService.shared) {
          self.tmdbService = tmdbService
          self.movieSelect()
      }

    // 선택 상태
    @Published var selectedMovie: Movie? = nil
    @Published var selectedTheaters: Set<Theater> = []
    @Published var selectedDate: Date? = nil

    // UI 제어/데이터
    @Published private(set) var week: [Date] = []
    @Published private(set) var showTheater = false
    @Published private(set) var showDate = false
    @Published private(set) var showtimes: [Theater: [Showtime]] = [:]   // Showtime으로 통일
    @Published private(set) var isShowtimeVisible = false

    private var bag = Set<AnyCancellable>()


    private func movieSelect() {
        // 극장 버튼 활성화: 영화 선택 여부
        $selectedMovie
            .map { $0 != nil }
            .assign(to: &$showTheater)

        // 날짜 선택 활성화: 영화 + 극장 1개 이상
        Publishers.CombineLatest(
            $selectedMovie.map { $0 != nil },
            $selectedTheaters.map { !$0.isEmpty }
        )
        .map { $0 && $1 }
        .assign(to: &$showDate)

        // 하단 상영정보 표시 조건: 영화 + 극장 + 날짜
        Publishers.CombineLatest3($selectedMovie, $selectedTheaters, $selectedDate)
            .map { movie, theaters, date in
                movie != nil && !theaters.isEmpty && date != nil
            }
            .assign(to: &$isShowtimeVisible)
    }

    
    // MARK: - JSON 원본(ShowtimeViewModel의 결과) 보관/사용
    private var rawShowtimeMovies: [ShowtimeMovie] = []

    func ingest(showtimes: [ShowtimeMovie]) {
        self.rawShowtimeMovies = showtimes
    }
    
    // MovieViewModel 안
    private func rawForSelectedMovie() -> ShowtimeMovie? {
        guard let sel = selectedMovie else { return nil }
        func norm(_ s: String) -> String { s.replacingOccurrences(of: " ", with: "").lowercased() }
        return rawShowtimeMovies.first { norm($0.title) == norm(sel.title) }
    }

    func ensureDefaultDateIfNeeded() {
        guard selectedDate == nil else { return }
        guard let raw = rawForSelectedMovie(),
              let firstYMD = raw.schedules.first?.date,
              let firstDate = ymdToDate(firstYMD) else { return }
        selectedDate = firstDate
    }
    

    func refreshShowtime() {
        guard let selectedMovie else {
            self.showtimes = [:]
            return
        }

        // 선택된 영화(제목 기준) 찾기
        guard let raw = rawShowtimeMovies.first(where: { $0.title == selectedMovie.title }) else {
            self.showtimes = [:]
            return
        }

        var bucket: [Theater: [Showtime]] = [:]

        //  문자열 비교 대신 "같은 날인지" 비교하도록 수정
        for schedule in raw.schedules {
            if let selectedDate,
               let scheduleDate = ymdToDate(schedule.date),
               !Calendar.current.isDate(scheduleDate, inSameDayAs: selectedDate) {
                continue
            }

            for area in schedule.areas {
                guard let theater = Theater(rawValue: area.area) else { continue }
                if !selectedTheaters.isEmpty && !selectedTheaters.contains(theater) { continue }

                for auditorium in area.items {           // ShowtimeAuditorium
                    for slot in auditorium.showtimes {   // ShowtimeSlot
                        if let start = combine(date: schedule.date, time: slot.start),
                           let end   = combine(date: schedule.date, time: slot.end) {

                            let showtime = Showtime(
                                theater: theater,
                                screenName: auditorium.auditorium,
                                format: auditorium.format,
                                start: start,
                                end: end,
                                remaining: slot.available,
                                capacity: slot.total
                            )
                            bucket[theater, default: []].append(showtime)
                        }
                    }
                }
            }
        }

        // 시간순 정렬
        for key in bucket.keys {
            bucket[key]?.sort { $0.start < $1.start }
        }

        self.showtimes = bucket
        
        // 디버깅용
        print("DBG selectedDate:", selectedDate as Any)
        print("DBG showtimes:", showtimes.mapValues { $0.count })
    }

     // MARK: - 날짜 + 시간 문자열을 Date로 변환
     private func combine(date ymd: String, time hm: String) -> Date? {
         let f = DateFormatter()
         f.locale = Locale(identifier: "ko_KR")
         f.timeZone = .current
         f.dateFormat = "yyyy-MM-dd HH:mm"
         return f.date(from: "\(ymd) \(hm)")
     }
    
    private func ymdToDate(_ ymd: String) -> Date? {
        let f = DateFormatter()
        f.locale = .init(identifier: "ko_KR")
        f.timeZone = .current
        f.dateFormat = "yyyy-MM-dd"
        return f.date(from: ymd)
    }

    //MARK: -TMDB API처리 함수들
    /// 뷰에서 호출할 진입 함수
       /// 예: .task { await viewModel.loadNowPlaying() }
       func loadNowPlaying(
           page: Int = 1,
           language: String = "ko-KR",
           region: String? = "KR"
       ) async {
           isLoading = true
           errorMessage = nil
           
           do {
               // TMDBService의 async/await 함수 호출
               let response = try await tmdbService.fetchNowPlayingAsync(
                   page: page,
                   language: language,
                   region: region
               )
               
               // 원본 DTO 저장 (상세 변환 등에 사용)
               nowPlayingDTOs = response.results
               
               // DTO -> 도메인(Movie)로 매핑
               nowPlayingMovies = response.results.map { $0.toMovie() }
               
           } catch {
               print("[MovieViewModel] Now Playing 요청 실패: \(error)")
               errorMessage = "영화 목록을 불러오지 못했습니다."
           }
           
           isLoading = false
       }
       
       /// 리스트에서 특정 영화를 선택했을 때 상세 정보 생성
       /// - Parameter index: nowPlayingMovies의 인덱스
       func selectMovie(at index: Int) {
           guard nowPlayingDTOs.indices.contains(index) else {
               print("[MovieViewModel] 잘못된 인덱스 접근: \(index)")
               return
           }
           
           let dto = nowPlayingDTOs[index]
           selectedMovieDetail = dto.toMovieDetail()
       }
       
       /// Movie 자체를 받아서 상세 생성하고 싶을 때 (선택사항)
       func selectMovie(_ movie: Movie) {
           // title 기준으로 DTO 매칭 (간단 구현)
           guard let dto = nowPlayingDTOs.first(where: { $0.title == movie.title }) else {
               print("[MovieViewModel] 해당 Movie에 대응하는 DTO를 찾을 수 없음")
               return
           }
           selectedMovieDetail = dto.toMovieDetail()
       }
   }

