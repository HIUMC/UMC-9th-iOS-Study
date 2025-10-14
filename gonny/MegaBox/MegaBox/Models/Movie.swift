//
//  HomeModel.swift
//  MegaBox
//
//  Created by 박병선 on 10/2/25.
//
import Foundation

//영화정보를 담고 있습니다.
struct Movie : Identifiable, Hashable {
    let id = UUID()
    let title: String
    let poster: String // 이미지 이름 or URL
    let audience: String?
}

//영화 상세정보를 담고 있습니다.
struct MovieDetail: Identifiable, Hashable {
    let id = UUID()
    let titleKR: String
    let titleEN: String
    let posterDetail: String
    let description: String
    let rating: String
    let releaseDate: String
    
    init(from movie: Movie, titleEN: String, posterDetail: String, description: String, rating: String, releaseDate: String) {
        self.titleKR = movie.title
        self.titleEN = titleEN
        self.posterDetail = posterDetail
        self.description = description
        self.rating = rating
        self.releaseDate = releaseDate
    }
}

//HomeView 하단 광고를 개별(영화별)로 만들기 위한 모델입니다.
struct Feed: Identifiable {
    let id = UUID()
    let title: String
    let image: String
}


//영화홍보 데이터입니다.
struct AdItem: Identifiable, Hashable {
    let id = UUID()
    let imageName: String
    let title: String
    let subtitle: String?
}

//영화관 지점별 장소 데이터를 감고 있습니다.
enum Theater: String, CaseIterable, Hashable, Identifiable {
    case gangnam = "강남"
    case hongdae = "홍대"
    case shinchon = "신촌"
    var id: String { rawValue }
}

//상영관 정보를 담고 있습니다
struct Showtime: Identifiable, Hashable {
    let id = UUID()
    let theater: Theater // 영화관 정보
    let screenName: String   // 상영관이름
    let format: String //2D,3D,4D
    let start: Date 
    let end: Date
    let remaining: Int
    let capacity: Int
}
