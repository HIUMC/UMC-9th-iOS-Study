//
//  MovieDetailViewModel.swift
//  MegaBox
//
//  Created by 박병선 on 10/2/25.
//
import SwiftUI

final class MovieDetailViewModel: ObservableObject {
    @Published var selectedTab: Tab = .info
  
    enum Tab: String, CaseIterable, Identifiable {
        case info = "상세 정보"
        case reviews = "실관람평"
        var id: String { rawValue }
    }
    
}

/*
 struct MovieDetail: Identifiable {
     let id = UUID()
     let titleKR: String
     let titleEN: String
     let poster: String
     let description: String
     let rating: String
     let releaseDate: String
 }
 */
