//
//  Route.swift
//  week1_homework
//
//  Created by 정승윤 on 10/2/25.
//

import SwiftUI

enum Route: Hashable {
    case home
    case login
    case detail(MovieModel)
    case profile
}
