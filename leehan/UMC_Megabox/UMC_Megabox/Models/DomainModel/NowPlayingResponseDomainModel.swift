//
//  MovieCardDomainModel.swift
//  UMC_Megabox
//
//  Created by 이한결 on 11/10/25.
//

import Foundation

struct NowPlayingResponseDomainModel {//.
    let results: [MovieCardDomainModel]
}//.


struct MovieCardDomainModel: Identifiable, Hashable {
    var id: Int//.
    
    /* 가로 스크롤에서 사용 */
    var moviePoster: URL? // 영화 포스터//.
    var movieName: String // 영화 이름
    var people: String // 누적관객수 하드코딩//.
    
    /* 영화 상세 정보 탭 */
    var bigPoster: URL?
    var subTitle: String//.
    var explaination: String
    var smallPoster: String // 작은 포스터 하드코딩
    var age: String // 관람 등급 하드코딩//.
    var date: String
}
//.
