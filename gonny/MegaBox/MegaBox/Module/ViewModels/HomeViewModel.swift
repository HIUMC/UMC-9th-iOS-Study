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
        Movie(title: "어쩔수가 없다", poster: "noOtherChoice_poster", audience: "누적관객수 20만"),
        Movie(title: "극장판 귀멸의 칼날", poster: "demonSlayer_poster", audience: "누적관객수 7만"),
        Movie(title: "F1 더 무비", poster: "f1_poster", audience: "누적관객수 4만"),
        Movie(title: "얼굴", poster: "face_poster", audience: "누적 관객수 10만")
    ]
    
    //카테고리 선택
    func selectCategory(_ category: String) {
        selectedCategory = category
    }
    
    // 상세정보 or 관람평
    @Published var selectedTab: Tab = .info
    
    //  현재 선택된 영화의 상세정보
    @Published var movieDetail: MovieDetail //initializer 필요함
    
    
    // 전체 더미 목록 (필요시 유지)
    @Published var movieDetails: [MovieDetail] = [
        MovieDetail(
            from: Movie(title: "F1 더 무비", poster: "f1_poster", audience: "12세 이상 관람가"),
            titleEN: "F1 : The Movie",
            posterDetail: "f1_promotion",
            description: """
            최고가 되지 못한 전설 VS 최고가 되고 싶은 루키
            
            한때 주목받는 유망주였지만 끔찍한 사고로 F1에서 우승하지 못하고
            한순간에 추락한 드라이버 ‘슌 헤이스’(브래드 피트).
            그의 오랜 동료인 ‘루벤 세레브네스’(하비에르 바르뎀)에게
            레이싱 복귀를 제안받으며 최하위 팀인 APGX에 합류한다.
            """,
            rating: "12세 이상 관람가",
            releaseDate: "2025.06.25"
        ),
        MovieDetail(
            from: Movie(title: "어쩔수가 없다",poster: "noOtherChoice", audience: "누적관객수 20만"),
            titleEN: "No Other Choice",
            posterDetail: "noOtherChoice",
            description: """
            ‘다 이루었다’는 생각이 들 만큼 삶에 만족하던 25년 경력의 제지 전문가 ‘만수’(이병헌). 아내 ‘미리’(손예진), 두 아이, 반려견들과 함께 행복한 일상을 보내던 만수는 회사로부터 돌연 해고
            통보를 받는다. “미안합니다. 어쩔 수가 없습니다.” 목이 잘려 나가는 듯한 충격에 괴로워하던 만수는, 가족을 위해 석 달 안에 반드시 재취업하겠다고 다짐한다. 그 다짐이 무색하게도, 그는 1년 넘게
            마트에서 일하며 면접장을 전전하고, 급기야 어렵게 장만한 집마저 빼앗길 위기에 처한다. 
            """,
            rating: "15세 관람가",
            releaseDate: "2024.09.24"
        ),
        MovieDetail(
            from: Movie(title: "극장판 귀멸의 칼날", poster: "demonSlayer_poster", audience: "누적관객수 7만"),
            titleEN: "Demon Slayer",
            posterDetail: "deadpool_promotion",
            description: """
            역대급 콤비가 돌아왔다! 세상에서 제일 유쾌한 히어로 듀오의 폭주 액션!
            """,
            rating: "청소년 관람불가",
            releaseDate: "2024.07.24"
        ),
        MovieDetail(
            from: Movie(title: "얼굴", poster: "face_poster", audience: "누적 관객수 10만"),
            titleEN: "Face",
            posterDetail: "face_poster",
            description: """
            최고가 되지 못한 전설 VS 최고가 되고 싶은 루키
            
            한때 주목받는 유망주였지만 끔찍한 사고로 F1에서 우승하지 못하고
            한순간에 추락한 드라이버 ‘슌 헤이스’(브래드 피트).
            그의 오랜 동료인 ‘루벤 세레브네스’(하비에르 바르뎀)에게
            레이싱 복귀를 제안받으며 최하위 팀인 APGX에 합류한다.
            """,
            rating: "12세 이상 관람가",
            releaseDate: "2025.06.25"
        )
        
    ]
    
     init() {
         // 더미 데이터 중 첫 번째를 기본으로 설정
         self.movieDetail =  MovieDetail(
            from: Movie(title: "F1 더 무비", poster: "f1_poster", audience: "12세 이상 관람가"),
            titleEN: "F1 : The Movie",
            posterDetail: "f1_promotion",
            description: """
            최고가 되지 못한 전설 VS 최고가 되고 싶은 루키
            
            한때 주목받는 유망주였지만 끔찍한 사고로 F1에서 우승하지 못하고
            한순간에 추락한 드라이버 ‘슌 헤이스’(브래드 피트).
            그의 오랜 동료인 ‘루벤 세레브네스’(하비에르 바르뎀)에게
            레이싱 복귀를 제안받으며 최하위 팀인 APGX에 합류한다.
            """,
            rating: "12세 이상 관람가",
            releaseDate: "2025.06.25"
        )
     }
     
   

    enum Tab: String, CaseIterable, Identifiable {
        case info = "상세 정보"
        case reviews = "실관람평"
        var id: String { rawValue }
    }
    
    //포스터 클릭 시 MovieDetailView로 넘어가게 하는 함수
        func detail(for movie: Movie) -> MovieDetail? {
            // 1. movies 배열에서 같은 Movie를 찾아서 index 구함
            if let index = movies.firstIndex(of: movie),
               movieDetails.indices.contains(index) {
                return movieDetails[index]
            }
            // 2. 혹시 몰라서 title 기준으로 한 번 더 탐색 (보너스)
            return movieDetails.first { $0.titleKR == movie.title }
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
