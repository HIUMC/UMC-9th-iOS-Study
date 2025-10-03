//
//  HomeViewModel.swift
//  Megabox
//
//  Created by 김지우 on 10/2/25.
//

import Foundation
import Observation

// MARK: - 2. ViewModel: 상태 및 표시 데이터 관리
@Observable
final class HomeViewModel {
    
    var selectedHeaderTab: HeaderTab = .home

    // 뷰의 상태: 현재 선택된 무비 섹션
    var selectedSegment: MovieSegment = .chart
    
    
    // 표시용 데이터: 무비차트 더미 데이터 
    var movieChartData: [MovieCardModel] = [
        MovieCardModel(
            title: "어쩔수가없다",
            imageAssetName: "nootherchoice",
            releaseDate: "23.09.28",
            audienceCount: "누적관객수 20만"
        ),
        MovieCardModel(
            title: "극장판 귀멸의 칼날",
            imageAssetName: "demonslayer",
            releaseDate: "8월 22일 대개봉",
            audienceCount: "누적관객수 1"
        ),
        MovieCardModel(
            title: "F1 더 무비",
            imageAssetName: "f1",
            releaseDate: nil,
            audienceCount: "누적관객수 2만"
        ),
        MovieCardModel(
            title: "F1 더 무비",
            imageAssetName: "f1",
            releaseDate: nil,
            audienceCount: "누적관객수 2만"
        ),
        MovieCardModel(
            title: "F1 더 무비",
            imageAssetName: "f1",
            releaseDate: nil,
            audienceCount: "누적관객수 2만"
        )
    ]

    // 표시용 데이터: 상영 예정 더미 데이터 (체크리스트에 따라 비워둠)
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
}
