//
//  NavigationRouter.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/5/25.
//

import SwiftUI

@Observable
class NavigationRouter {
    // NavigationStack과 바인딩될 경로. NavigationPath는 다양한 타입을 담을 수 있음
    var path = NavigationPath()

    // 특정 경로로 이동하는 메서드
    func push(_ route: Route) {
            path.append(route)
    }

    // 이전 화면으로 돌아가는 메서드
    func pop() {
            if !path.isEmpty {
                path.removeLast()
        }
    }

    // 가장 처음 화면(루트)으로 돌아가는 메서드
    func navigateToRoot() {
        path = NavigationPath()
    }
}
