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
    // MARK: - JSON data 관련
    @Published var isLoading1: Bool = false
    @Published var movieInfo: TopDomainModel?
    
    // MARK: - 입력 (사용자 선택)
    @Published var selectedMovie: Movie?
    @Published var selectedTheaters: [Theater] = []
    @Published var selectedDate: Date?
    @Published var selectedShowtime: ShowtimesDomainModel?

    // MARK: - 출력 (UI에 보여줄 데이터)
    @Published var availableTheaters: [Theater] = []
    @Published var availableDates: [Date] = []
    @Published var groupedItems: [AreasDomainModel] = []
    
    // MARK: - UI 상태
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // 영화 상영일정 더미데이터
    //private var movieService = MovieService()

    private var cancellables = Set<AnyCancellable>()
    
    
    // 영화와 상영관 더미데이터
    let allMovies: [Movie] = [ .init(id: "F1 더 무비", name: "F1 더 무비", imageName: "poster_f1", ageRating: 15),
                               .init(id: "귀멸의 칼날: 무한성", name: "귀멸의 칼날: 무한성", imageName: "poster_muhanseong", ageRating: 15),
                               .init(id: "어쩔수가없다", name: "어쩔수가없다", imageName: "poster_no_choice", ageRating: 15),
                               .init(id: "얼굴", name: "얼굴", imageName: "얼굴", ageRating: 15),
                               .init(id: "모노노케히메", name: "모노노케히메", imageName: "poster_mononoke", ageRating: 15),
                               .init(id: "보스", name: "보스", imageName: "poster_boss", ageRating: 15),
                               .init(id: "야당", name: "야당", imageName: "poster_yadang", ageRating: 15),
                               .init(id: "더로제스", name: "더로제스", imageName: "poster_the_roses", ageRating: 15)]
    
    let allTheaters: [Theater] = [ .init(name: "강남"),
                                   .init(name: "홍대"),
                                   .init(name: "신촌")]

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
                    self?.selectedTheaters = []
                    self?.selectedDate = nil
                    return
                }
                
                // 영화가 선택되면, 준비해둔 전체 극장 목록을 보여줌
                self?.availableTheaters = self?.allTheaters ?? []
        
                // 이전에 선택했던 극장이 있다면 초기화
                self?.selectedTheaters = []
                self?.availableDates = []
                self?.selectedDate = nil
                self?.groupedItems = []
                self?.errorMessage = nil
            }
            .store(in: &cancellables)

        // 상영관이 선택되면 -> 날짜 목록을 활성화한다.
        $selectedTheaters
            /// compactMap은 nil이 아닐 때만 통과시키는 필터 역할
            /// 이전 selectedMovie의 sink에서 selectedTheater를 nil로 바꾸어 놓았기 때문에
            /// 일단 무조건 여기서 걸러짐
            /// 상영관을 선택하면 selectedTheater이 nil이 아니게 되면서 통과하게 됨
            /// 이전에 선택한 영화와 상영관의 날짜가 보이지 않게 하기 위함
            //.compactMap { $0 }
            /// map은 들어온 값을 다른 형태로 변환하는 역할
            /// 받은 theater를 Date 배열로 만들어서 반환함
            
            .map { $0.isEmpty } // selectedTheater 배열이 비어있는지 확인
            .removeDuplicates()
            .sink { [weak self] isEmpty in
                if isEmpty { // 배열이 비어있으면 초기화
                    self?.availableDates = []
                    self?.selectedDate = nil
                } else {
                    let today = Date()
                    let dates = (0..<7).compactMap { i in
                        Calendar.current.date(byAdding: .day, value: i, to: today)
                    }
                    self?.availableDates = dates
                    self?.selectedDate = nil
                }
            }
            .store(in: &cancellables)
        

        // 영화, 상영관, 날짜가 모두 선택되면 상영 시간표 불러옴
        Publishers.CombineLatest3($selectedMovie, $selectedTheaters, $selectedDate)
            .debounce(for: 0.2, scheduler: RunLoop.main)
            /// 세 가지 값이 모두 nil이 아닌 유효한 값인지 확인
            /// (Movie, Theater, Date) 튜플을 반환
            .compactMap { movie, theater, date -> (Movie, [Theater], Date)? in
                guard let movie = movie, !theater.isEmpty, let date = date else {
                    // 세 개 중 하나라도 nil이면 nil을 반환하여 파이프라인 중단
                    return nil
                }
                // 세 개 모두 유효하면 튜플로 묶어서 통과
                return (movie, theater, date)
            }
            // flatMap에서 movie, theater, date 튜플을 받아 AnyPublisher<[showtime], Error> publisher 를 반환
            .flatMap { movie, theater, date -> AnyPublisher<[AreasDomainModel], Error> in
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
            }, receiveValue: { [weak self] items in
                // 결과값이 비어있으면 "시간표 없음" 메시지 설정
                if items.isEmpty {
                    self?.errorMessage = "선택한 극장에 상영시간표가 없습니다."
                } else {
                    self?.errorMessage = nil // 결과가 있으면 에러 메시지 제거
                }
                // 최종 결과를 showtimes 프로퍼티에 할당
                self?.groupedItems = items
            })
            .store(in: &cancellables)
        
    }
    
    // fetchShowtimes 함수는 Movie, Theater, Date 값을 받아서 AnyPublisher<[Showtime], Error> publisher를 반환함
    private func fetchShowtimes(movie: Movie, theater: [Theater], date: Date) -> AnyPublisher<[AreasDomainModel], Error> {
        self.isLoading = true // 로딩 시작
        self.errorMessage = nil // 이전 메시지 제거
        self.groupedItems = [] // 이전 목록 제거
        
        return self.fetchItems(movie: movie, theater: theater, date: date)
            .handleEvents(receiveCompletion: { [weak self] _ in
                self?.isLoading = false })
            .eraseToAnyPublisher()
            
    }
    
    func fetchInfos() async {
        isLoading1 = true
        
        // JSON 파일 읽기: Bundle.main.url
        guard let url = Bundle.main.url(forResource: "MovieSchedule", withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return }
        
        do {
            // JSON -> APIResponse
            let response = try JSONDecoder().decode(APIResponse.self, from: data)
            
            await MainActor.run {
                // APIResponse의 toDomain() 메서드 호출 -> movieInfo 프로퍼티에 저장
                self.movieInfo = response.toDomain()
                self.isLoading1 = false
            }
        } catch {
            print("Decoding error:", error)
        }
        
        /// ** 전체 흐름 **
        ///  fetchInfos 함수 호출 시 JSON --> APIResponse라는 DTO로 변환
        ///  APIResponse 의 toDomain() 함수를 호출하여 TopDomainModel로 변환
        ///  변환된 TopDomainModel 객체가 movieInfo 프로퍼티에 저장
    }
    
    func fetchItems(movie: Movie, theater: [Theater], date: Date) -> AnyPublisher<[AreasDomainModel], Error> {
        
        return Future<[AreasDomainModel], Error> { promise in
                
                // 실제 네트워크 통신을 흉내 내는 딜레이
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    
                    guard let movieInfo = self.movieInfo else { return promise(.success([])) }
                    // 전달받은 Date 객체를 YYYY-MM-DD 형태의 문자열로 변환
                    let dateString = self.dateFormatter().string(from: date)
                    
                    guard let movies = movieInfo.data.movies.first(where: { $0.title == movie.id }) else {
                        print("일치하는 영화 없음")
                        return promise(.success([]))
                    }
                    
                    guard let schedules = movies.schedules.first(where: { $0.date == dateString }) else {
                        print("일치하는 날짜 없음")
                        return promise(.success([]))
                    }
                    
                    // 선택된 극장 이름을 selectedMovieNames에 추출
                    let selectedMovieNames = Set(theater.map { $0.name })
                    
                    // matchingAreas에 필터링된 결과만 저장
                    let matchingAreas = schedules.areas.filter { area in
                        selectedMovieNames.contains(area.area)
                    }
                    
                    guard !matchingAreas.isEmpty else {
                        print("일치하는 극장 없음")
                        return promise(.success([]))
                    }
                    
                    let results = matchingAreas
                    
                    // 필터링된 결과를 반환: items 배열 (상영관 이름, format, 상영 시간 들의 배열)
                    promise(.success(results))
                }
            }
            .eraseToAnyPublisher()
        }
    
    private func dateFormatter() -> DateFormatter {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                formatter.locale = Locale(identifier: "ko_KR") // 한국 시간 기준
                return formatter
            }
}

