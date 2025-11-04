//
//  MoviesDTO.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/27/25.
//

import Foundation

struct MoviesDTO: Codable {
    let movies: [MovieDTO]
    
    enum CodingKeys: String, CodingKey {
        case movies = "movies"
    }
}

extension MoviesDTO {
    func toDomain() -> MoviesDomainModel {
        return MoviesDomainModel(
            movies: movies.map { $0.toDomain() }
        )
    }
}
