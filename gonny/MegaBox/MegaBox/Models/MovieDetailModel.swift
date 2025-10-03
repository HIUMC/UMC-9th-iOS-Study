//
//  MovieDetailModel.swift
//  MegaBox
//
//  Created by 박병선 on 10/2/25.
//
import Foundation
import SwiftUI

struct MovieDetail: Identifiable {
    let id = UUID()
    let titleKR: String
    let titleEN: String
    let poster: String
    let description: String
    let rating: String
    let releaseDate: String
}

    extension MovieDetail {
        static func mock(for movie: Movie) -> MovieDetail {
            MovieDetail(
               // id: movie.id,
                titleKR: movie.title,
                titleEN: "Dummy Title EN",
                poster: movie.poster,
                description: "Dummy description",
                rating: "12세 관람가",
                releaseDate: "2025-10-02"
            )
        }
    }

