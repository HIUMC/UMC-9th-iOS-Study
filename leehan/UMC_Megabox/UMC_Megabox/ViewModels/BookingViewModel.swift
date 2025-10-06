//
//  BookingViewModel.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/5/25.
//

import Foundation
import Combine

/// Combine은 **시간의 흐름에 따라 발생하는 데이터의 변화** 를 다루는 방법
/// 사용자의 터치 이벤트, 네트워크 응답, 사용자가 검색창에 입력하는 글자 하나하나 등
/// 언제 어떤 순서로 일어날지 알 수 없는 비동기적인 이벤트들을 데이터 파이프라인으로 처리한다

class BookingViewModel: ObservableObject {
    
    // MARK: - 입력 (사용자 선택)
    @Published var selectedMovie: Movie?
    @Published var selectedTheater: Theater?
    @Published var selectedDate: Date?
    @Published var selectedShowtime: Showtime?

    // MARK: - 출력 (UI에 보여줄 데이터)
    @Published var availableTheaters: [Theater] = []
    @Published var availableDates: [Date] = []
    @Published var showtimes: [Showtime] = []
    
    // MARK: - UI 상태
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var movieService = MovieService()

    private var cancellables = Set<AnyCancellable>()
    
    
    let allMovies: [Movie] = [ .init(id: "F1", name: "F1", imageName: "F1", ageRating: 15),
                               .init(id: "무한성", name: "무한성", imageName: "무한성", ageRating: 15),
                               .init(id: "어쩔수가없다", name: "어쩔수가없다", imageName: "어쩔수가없다", ageRating: 15),
                               .init(id: "얼굴", name: "얼굴", imageName: "얼굴", ageRating: 15),
                               .init(id: "모노노케히메", name: "모노노케히메", imageName: "모노노케히메", ageRating: 15),
                               .init(id: "보스", name: "보스", imageName: "보스", ageRating: 15),
                               .init(id: "야당", name: "야당", imageName: "야당", ageRating: 15),
                               .init(id: "더로제스", name: "더로제스", imageName: "더로제스", ageRating: 15)]
    
    let allTheaters: [Theater] = [ .init(id: "강남", name: "강남"),
                                   .init(id: "홍대", name: "홍대"),
                                   .init(id: "신촌", name: "신촌")]

    init() {
        setupPipelines()
    }

    private func setupPipelines() {

        // 선택되는 영화
        $selectedMovie
            .sink { [weak self] movie in
                // 영화가 선택되었는지 확인
                guard movie != nil else { // movie == nil 이면 (영화 선택이 없으면) 밑의 코드 실행
                    self?.availableTheaters = []
                    self?.selectedTheater = nil
                    self?.selectedDate = nil
                    
                    return
                }
                
                // 영화가 선택되면, 준비해둔 전체 극장 목록을 보여줌
                self?.availableTheaters = self?.allTheaters ?? []
        
                // 이전에 선택했던 극장이 있다면 초기화
                self?.selectedTheater = nil
                self?.availableDates = []
                self?.selectedDate = nil
                self?.showtimes = []
                self?.errorMessage = nil
            }
            .store(in: &cancellables)

        // 상영관이 선택되면 -> 날짜 목록을 활성화한다.
        $selectedTheater
            /// compactMap은 nil이 아닐 때만 통과시키는 필터 역할
            /// 이전 selectedMovie의 sink에서 selectedTheater를 nil로 바꾸어 놓았기 때문에
            /// 일단 무조건 여기서 걸러짐
            /// 상영관을 선택하면 selectedTheater이 nil이 아니게 되면서 통과하게 됨
            /// 이전에 선택한 영화와 상영관의 날짜가 보이지 않게 하기 위함
            .compactMap { $0 }
            /// map은 들어온 값을 다른 형태로 변환하는 역할
            /// 받은 theater를 Date 배열로 만들어서 반환함
            .map { theater -> [Date] in
                // 오늘 날짜를 기준으로 7일간의 날짜 배열을 생성
                let today = Date() // 실행 시간 기준으로 초기화함
                return (0..<7).compactMap { i in // 0 ~ 6 순환하며 compactMap을 통해 배열을 만듬 -> nil이 되는 값 걸러줌
                    Calendar.current.date(byAdding: .day, value: i, to: today)
                    /// byAdding : 일/시/분 을 더할것이다
                    /// value : 얼만큼 더할것이다
                    /// to : 언제부터 더할것이다
                }
            }
            .sink { [weak self] dates in
                // 생성된 날짜 배열을 availableDates에 할당
                self?.availableDates = dates
                
                // 이전에 선택했던 날짜가 있다면 초기화
                self?.selectedDate = nil
                self?.showtimes = []
                self?.errorMessage = nil
            }
            .store(in: &cancellables)
        

        // 영화, 상영관, 날짜가 모두 선택되면 상영 시간표 불러옴
        Publishers.CombineLatest3($selectedMovie, $selectedTheater, $selectedDate)
            .debounce(for: 0.2, scheduler: RunLoop.main)
            /// 세 가지 값이 모두 nil이 아닌 유효한 값인지 확인
            /// (Movie, Theater, Date) 튜플을 반환
            .compactMap { movie, theater, date -> (Movie, Theater, Date)? in
                guard let movie = movie, let theater = theater, let date = date else {
                    // 세 개 중 하나라도 nil이면 nil을 반환하여 파이프라인 중단
                    return nil
                }
                // 세 개 모두 유효하면 튜플로 묶어서 통과
                return (movie, theater, date)
            }
            // flatMap에서 movie, theater, date 튜플을 받아 AnyPublisher<[showtime], Error> publisher 를 반환
            .flatMap { movie, theater, date -> AnyPublisher<[Showtime], Error> in
                return self.fetchShowtimes(movie: movie, theater: theater, date: date)
            }
            .receive(on: DispatchQueue.main) // 결과를 항상 메인 스레드에서 받도록
            .sink(receiveCompletion: { [weak self] completion in
                /// receiveCompletion, receiveValue는 .sink에서 요구하는 두 가지 값
                /// receivevalue는 스트림을 통해 성공적으로 데이터가 도착했을 때 호출됨
                /// receiveCompletion는 데이터 스트림이 완전히 종료되었을 때 호출됨
                /// receiveCompletion는 .failure(Error), .finished 두 가지 값을 가질 수 있음
                /// .finished는 모든 데이터 전송이 성공적으로 완료되었을 떄, .failure(Error)는 에러가 발생했을 때
                self?.isLoading = false // 통신이 완료되면(성공/실패 모두) 로딩 상태를 false로 변경
                // 에러가 발생한 경우 에러 메시지 설정
                if case .failure(_) = completion {
                    self?.errorMessage = "상영 시간표를 불러오는데 실패했습니다."
                }
            }, receiveValue: { [weak self] showtimes in
                // 결과값이 비어있으면 "시간표 없음" 메시지 설정
                if showtimes.isEmpty {
                    self?.errorMessage = "선택한 극장에 상영시간표가 없습니다."
                } else {
                    self?.errorMessage = nil // 결과가 있으면 에러 메시지 제거
                }
                // 최종 결과를 showtimes 프로퍼티에 할당
                self?.showtimes = showtimes
            })
            .store(in: &cancellables)
        
    }
    
    // fetchShowtimes 함수는 Movie, Theater, Date 값을 받아서 AnyPublisher<[Showtime], Error> publisher를 반환함
    private func fetchShowtimes(movie: Movie, theater: Theater, date: Date) -> AnyPublisher<[Showtime], Error> {
        self.isLoading = true // 로딩 시작
        self.errorMessage = nil // 이전 메시지 제거
        self.showtimes = [] // 이전 목록 제거
        
        return movieService.fetchShowtimes(movie: movie, theater: theater, date: date)
            .handleEvents(receiveCompletion: { [weak self] _ in
                self?.isLoading = false })
            .eraseToAnyPublisher()
            
    }
}
