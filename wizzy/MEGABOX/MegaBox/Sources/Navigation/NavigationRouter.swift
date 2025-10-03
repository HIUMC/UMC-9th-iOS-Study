//
//  NavigationRouter.swift
//  MegaBox
//
//  Created by 이서현 on 9/29/25.
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
