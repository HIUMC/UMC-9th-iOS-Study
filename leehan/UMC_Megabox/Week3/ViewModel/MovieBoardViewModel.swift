//
//  MovieBoardViewModel.swift
//  UMC_Megabox
//
//  Created by 이한결 on 9/30/25.
//

import SwiftUI
import Foundation

@Observable
class MovieBoardViewModel {
    var movieBoards = [
        MovieBoard(MovieImage: Image("MovieBoardImage2"), Title: "9월, 메가박스의 영화들(1) - 명작들의 재개봉'", SubTitle: "<모노노케 히메>, <퍼펙트 블루>"),
        MovieBoard(MovieImage: Image("MovieBoardImage1"), Title: "메가박스 오리지널 티켓 Re.37 <얼굴>", SubTitle: "영화 속 양극적인 감정의 대비")
    ]
}

