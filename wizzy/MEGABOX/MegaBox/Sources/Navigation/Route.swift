//
//  Route.swift
//  MegaBox
//
//  Created by 이서현 on 9/29/25.
//


import SwiftUI

enum Route: Hashable {
    case home
    case login
    case detail(MovieModel)
    case profile
}
