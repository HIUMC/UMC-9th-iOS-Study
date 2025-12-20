//
//  HomeViewModel.swift
//  Megabox
//
//  Created by 김지우 on 10/2/25.
//

import Foundation
import Observation //  Moya는 ViewModel이 알 필요 없습니다.

// MARK: - 2. ViewModel: 상태 및 표시 데이터 관리
@Observable
final class HomeViewModel {
    
    //뷰 상태
    var selectedHeaderTab: HeaderTab = .home
    var selectedSegment: MovieSegment = .chart
    
    //API 연동을 위한 상태
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    //API 응답을 받아 채울 빈 배열
    var movieChartData: [MovieCardModel] = []
    
    //상영 예정 더미 데이터 (체크리스트에 따라 비워둠)
    var upcomingData: [MovieCardModel] = []
    
    //표시 로직: 현재 선택된 탭에 따라 보여줄 영화 목록 계산
    var currentMovieList: [MovieCardModel] {
        switch selectedSegment {
        case .chart:
            return movieChartData
        case .upcoming:
            return upcomingData
        }
    }
    
    //무비피드 데이터 (더미데이터 하드코딩)
    var movieFeedList: [MovieFeedModel] = [
        MovieFeedModel(
            title: "9월, 메가박스의 영화들(1) - 명작들의 재개봉",
            subtitle: "<모노노케 히메>, <퍼펙트 블루>",
            contentDescription: nil,
            imageAssetName: "hime_mini"
        ),
        MovieFeedModel(
            title: "메가박스 오리지널 티켓 Re.37 <얼굴>",
            subtitle: nil,
            contentDescription: "영화 속 압도적인 감정 표출 대비",
            imageAssetName: "theugly_mini"
        )
    ]
    
    
    
    // APIManager 싱글톤 인스턴스
    private let apiManager = APIManager.shared
    
    //뷰모델에서 async/await로 API 호출
    @MainActor
    func fetchNowPlayingMovies() async {
        // 이미 로딩 중이거나 데이터가 있으면 중복 호출 방지
        guard !isLoading, movieChartData.isEmpty else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let response: NowPlayingResponse = try await apiManager.request(
                .nowPlaying(language: "ko-KR", page: 1, region: "KR")
            )
            
            //DTO(MovieResult)를 UI Model(MovieCardModel)로 매핑
            let mappedMovies = response.results.compactMap { movieDTO -> MovieCardModel? in
                
                // DTO에 title이 nil일 경우를 대비 (필수값 체크)
                guard let title = movieDTO.title else { return nil }
                
                return MovieCardModel(
                    id: movieDTO.id,
                    title: title,
                    posterURL: movieDTO.fullPosterURL, // DTO의 편의 프로퍼티 사용
                    releaseDate: movieDTO.releaseDate ?? "N/A",
                    
                    //TMDB에 없는 데이터는 하드코딩
                    audienceCount: "누적 10만",
                    rating: "12세"
                )
            }
            
            // 메인 스레드에서 데이터 업데이트
            self.movieChartData = mappedMovies
            
        } catch {
            //do-try-catch로 에러 핸들링
            errorMessage = "영화를 불러오지 못했습니다: \(error.localizedDescription)"
            print("[API Error - HomeView]:", error)
        }
        
        isLoading = false
    }
}
