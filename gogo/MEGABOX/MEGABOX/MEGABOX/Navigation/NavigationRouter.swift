//
//  NavigationRouter.swift
//  MEGABOX
//
//  Created by 고석현 on 10/2/25.
//

import SwiftUI
import Foundation

@Observable
class NavigationRouter {
    var path = NavigationPath()

    func push(_ route: Route) {
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
