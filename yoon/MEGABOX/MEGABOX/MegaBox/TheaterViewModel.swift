//
//  TheaterViewModel.swift
//  MEGABOX
//
//  Created by 정승윤 on 10/7/25.
//

import SwiftUI
import Combine

final class TheaterViewModel: ObservableObject {
    @Published var theaters: [TheaterModel] = [
        TheaterModel(name: "강남"),
        TheaterModel(name: "홍대"),
        TheaterModel(name: "신촌")
    ] // 초기값 설정
    
    @Published var selectedTheater: Set<TheaterModel> = []
    // 중복 선택 가능
    @Published var selectedMovie: MovieModel? = nil
    // 옵셔널
    @Published private(set) var isEnabled: Bool = false
    // 극장 버튼 활성화여부, 내부에서만 수정 가능
    @Published var selectedDate: Date? = nil
    // 날짜 관리
    @Published private(set) var ShowTheaterInfo: Bool = false
    // 상영관 표시
    @Published var bag = Set<AnyCancellable>()
    
    init() {
        $selectedMovie.map { $0 != nil}
            .assign(to: &$isEnabled)
        // selectedMovie가 바뀔때마다 이벤트 발생
        // 영화가 선택되었는지 확인 후, isEnabled에 반영 (자기 자신에 있는 isEnabled)
        
        Publishers.CombineLatest3($selectedMovie, $selectedTheater, $selectedDate)
            .map{movie,theater,date in
                return movie != nil && !theater.isEmpty && date != nil}
            .assign(to: &$ShowTheaterInfo)
        // 세개의 퍼블리셔 조합 -> 모두 존재하면 ShowTheaterInfo True 설정
    }

    func selectTheater(_ theater: TheaterModel) {
        guard isEnabled else { return } // true일때만 작동
        if selectedTheater.contains(theater) {
            selectedTheater.remove(theater)
        } else {
            selectedTheater.insert(theater)
        }
    } // 토글 기능
}
