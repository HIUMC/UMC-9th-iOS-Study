//
//  MoviesDomainModel.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/27/25.
//

import Foundation

struct MoviesDomainModel {
    let movies: [MovieDomainModel]
}

extension MoviesDomainModel {
    func toDTO() -> MoviesDTO {
        return MoviesDTO(
            movies: movies.map { $0.toDTO() }
        )
    }
}
