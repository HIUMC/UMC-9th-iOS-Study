//
//  NavigationRouter.swift
//  week1_homework
//
//  Created by 정승윤 on 10/2/25.
//

import Observation
import Foundation
import SwiftUI

// 하나만 써야한다..
@Observable
class NavigationRouter: ObservableObject {
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
