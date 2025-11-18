//
//  MovieSearchViewModel.swift
//  MEGABOX
//
//  Created by 고석현 on 10/9/25.
//

import Foundation

//
//  MovieSearchViewModel.swift
//  MEGABOX
//
//  Created by 고석현 on 10/10/25.
//

import SwiftUI
import Combine

// MARK: - 영화 검색 뷰모델
// 사용자가 입력한 검색어(query)에 따라 더미 영화 목록을 필터링해서 결과로 보여줌
final class MovieSearchViewModel: ObservableObject {
    
    // MARK: - 영화 더미 데이터
    // 실제 얍에서는 API로 대체. 지금은 MovieModel 구조에 맞게 정의함.
    @Published var movies: [MovieModel] = [
        .init(title: "어쩔 수가 없다", poster: "poster1", countAudience: "20만", description: nil, releaseDate: nil, rating: nil),
        .init(title: "극장판 귀멸의 칼날", poster: "poster2", countAudience: "1", description: nil, releaseDate: nil, rating: nil),
        .init(title: "F1 더 무비", poster: "poster3", countAudience: "30만",
              description: "최고가 되지 못한 전설 VS 최고가 되고 싶은 루키\n\n한때 주목받는 유망주였지만 끔찍한 사고로 F1에서 우승하지 못하고\n한순간에 추락한 드라이버 ‘손; 헤이스’(브래드 피트).\n그의 오랜 동료인 ‘루벤 세르반테스’(하비에르 바르뎀)에게\n레이싱 복귀를 제안받으며 최하위 팀인 APGX에 합류한다.",
              releaseDate: "2025.06.25 개봉",
              rating: "12세 이상 관람가"),
        .init(title: "얼굴", poster: "poster4", countAudience: nil, description: nil, releaseDate: nil, rating: nil),
        .init(title: "모노노케 히메", poster: "poster5", countAudience: nil, description: nil, releaseDate: nil, rating: nil),
        .init(title: "보스", poster: "poster6", countAudience: nil, description: nil, releaseDate: nil, rating: nil),
        .init(title: "야당", poster: "poster7", countAudience: nil, description: nil, releaseDate: nil, rating: nil),
        .init(title: "THE ROSES", poster: "poster8", countAudience: nil, description: nil, releaseDate: nil, rating: nil)
    ]
    
    // MARK: - 상태 관리용 프로퍼티
    @Published var query: String = ""                  // 검색어
    @Published var results: [MovieModel] = []          // 검색 결과
    @Published var isLoading: Bool = false             // 로딩 상태
    @Published var errorMessage: String? = nil         // 에러 메시지
    @Published var selectedMovie: MovieModel? = nil    // 사용자가 선택한 영화
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - 초기화
    init() {
        setupSearchPipeline()
    }
    
    // MARK: - 검색 파이프라인 구성
    // query 값이 바뀔 때마다 debounce → filter → 결과 업데이트 순으로 처리됨
    private func setupSearchPipeline() {
        $query
            .debounce(for: .milliseconds(400), scheduler: DispatchQueue.main) // 입력 딜레이 (타이핑 안정화)
            .removeDuplicates() // 같은 단어 반복 입력 방지
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.errorMessage = nil // 새 검색 시 에러 초기화
            })
            .flatMap { [weak self] query in
                self?.performSearch(for: query) ?? Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let err) = completion {
                    self?.errorMessage = "검색 실패: \(err.localizedDescription)"
                    self?.results = []
                }
            } receiveValue: { [weak self] foundMovies in
                self?.results = foundMovies
            }
            .store(in: &cancellables)
    }
    
    // MARK: - 실제 검색 로직 (더미 데이터 기반)
    // 입력된 query가 포함된 영화 제목을 필터링함
    private func performSearch(for query: String) -> AnyPublisher<[MovieModel], Error> {
        Future<[MovieModel], Error> { [weak self] promise in
            guard let self else { return }
            let delay = Double(Int.random(in: 300...700)) / 1000.0 // 약간의 지연 효과
            DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
                let lowerQuery = query.lowercased()
                let filtered = self.movies.filter { $0.title.lowercased().contains(lowerQuery) }
                promise(.success(filtered))
            }
        }
        .handleEvents(
            receiveSubscription: { _ in
                DispatchQueue.main.async { self.isLoading = true }
            },
            receiveCompletion: { _ in
                DispatchQueue.main.async { self.isLoading = false }
            }
        )
        .eraseToAnyPublisher()
    }
}
