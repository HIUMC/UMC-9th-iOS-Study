//
//  HomeViewModel.swift
//  MegaBox
//
//  Created by 박병선 on 10/2/25.
//
import SwiftUI

final class HomeViewModel: ObservableObject {
    // 현재 선택된 카테고리
    @Published var selectedCategory: String = "무비차트"
    
    // 영화 더미 데이터 (실제로는 API fetch 가능)
    @Published var movies: [Movie] = [
        Movie(title: "어쩔수가 없다", poster: "noOtherChoice", audience: "누적관객수 20만"),
        Movie(title: "극장판 귀멸의 칼날", poster: "demonSlayer_poster", audience: "누적관객수 7만"),
        Movie(title: "F1 더 무비", poster: "f1_poster", audience: "누적관객수 4만"),
        Movie(title: "얼굴", poster: "face_poster", audience: "누적 관객수 10만")
    ]
    
    // 피드 데이터
    @Published var feeds: [Feed] = [
        Feed(title: "알고보면 더 재밌는 무비피드", image: "feed1")
    ]
    
    func selectCategory(_ category: String) {
        selectedCategory = category
    }
}

//하단의 adVM
final class AdViewModel: ObservableObject {
    @Published var items: [AdItem] = [
        AdItem(imageName: "mono_san",
                 title: "9월, 메가박스의 영화들(1) - 명작들의 재개봉",
                 subtitle: "<모노노케 히메>, <퍼펙트 블루>"),
        AdItem(imageName: "face_promotion",
                 title: "메가박스 오리지널 티켓 Re.37 <얼굴>",
                 subtitle: "영화 속 양극적인 감정의 대비")
    ]
}
