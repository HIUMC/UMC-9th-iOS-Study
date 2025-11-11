//
//  MovieSearchViewModel.swift
//  MegaBox
//
//  Created by 박병선 on 10/9/25.
//
import SwiftUI
import Combine


final class MovieSearchViewModel: ObservableObject {

    //영화 목록 더미 데이터
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

    //검색창에서 입력되는 텍스트
    @Published var query: String = "" // 검색 위한 쿼리
    @Published var results: [Movie] = [] // 검색 결과 목록
    @Published var isLoading = false //검색 중이리 때 로딩 상태
    @Published var errorMessage: String? //검색 실패 시 에러 메세지

    @Published var selectedMovie: Movie? = nil // 사용자가 클릭한 영화저장

    private var bag = Set<AnyCancellable>() //Combine 구독 저장소(메모리 해제 방지)

    //initializer - 검색 흐름 파이프라인
    init() {
        $query //시작 Publisher
            .debounce(for: .milliseconds(400), scheduler: DispatchQueue.main)
            .removeDuplicates()//같은 값으로 검색하는 것을 방지
            .handleEvents(receiveOutput: { [weak self] _ in //검색 직전 에러메세지 초기화
                self?.errorMessage = nil
            })
            .flatMap { query in //query 값을 받아서 search() 함수를 실행하고 그 결과를 downstream으로 보냄
                self.search(query: query)
            }
            .receive(on: DispatchQueue.main) //UI업데이트는 메인 스레드에서 이뤄져야 하므로 메인큐로 전환
            .sink { [weak self] completion in //Publisher의 최종 구독 단계
                if case .failure(let err) = completion { //에러처리(검색 실패)
                    self?.errorMessage = "검색 실패: \(err.localizedDescription)"
                    self?.results = []
                }
            } receiveValue: { [weak self] items in//성공 시 results에 결과 저장
                self?.results = items
            }
            .store(in: &bag)
    }

    //검색 함수
    private func search(query: String) -> AnyPublisher<[Movie], Error> {
        //Future는 한 번만 결과를 내는 비동기 Publisher
        return Future<[Movie], Error> { [weak self] promise in
            let delay = Double(Int.random(in: 300...700)) / 1000.0
            guard let self else { return }

            DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
                let filtered = self.movies.filter { $0.title.lowercased().contains(query) }
                promise(.success(filtered))
            }
        }
        .handleEvents(
            receiveSubscription: { _ in //검색 실패
                DispatchQueue.main.async {
                    self.isLoading = true
                }
            },
            receiveCompletion: { _ in //검색 성공
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        )
        .eraseToAnyPublisher()
    }

}

