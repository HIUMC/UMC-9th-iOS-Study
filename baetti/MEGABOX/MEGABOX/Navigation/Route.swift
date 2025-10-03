//
//  Route.swift
//  MEGABOX
//
//  Created by 박정환 on 10/1/25.
//

import SwiftUI

enum Route: Hashable {
    case login
    case home
    case profile
    case detail(MovieModel)
}
