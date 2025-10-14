//
//  Route.swift
//  MEGABOX
//
//  Created by 고석현 on 10/2/25.
//

import SwiftUI

enum Route: Hashable {
    case home
    case login
    case memberInfo
    case movieDetail(movie: MovieModel)
}
