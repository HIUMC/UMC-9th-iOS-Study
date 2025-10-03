//
//  AppRouter.swift
//  Megabox
//
//  Created by 김지우 on 10/2/25.
//


import SwiftUI
import Foundation

@Observable
class NavigationRouter {
    var path = NavigationPath()

    func push(_ route: NavigationDestination) {
        path.append(route)
    }

    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }

    func reset() {
        path = NavigationPath()
    }

}
