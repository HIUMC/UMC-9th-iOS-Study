//
//  NavigationRouter.swift
//  MegaBox
//
//  Created by 박병선 on 10/1/25.
//
import SwiftUI
import Observation

@Observable
class NavigationRouter: ObservableObject {
    /// NavigationStack의 경로
    var path = NavigationPath()
    
    /// 특정 화면으로 이동 (화면 타입을 직접 append)
    func push<T: Hashable>(_ destination: T) {
        path.append(destination)
    }
    
    /// 마지막 화면 제거 (Pop)
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    /// 루트로 돌아가기 (Reset)
    func reset() {
        path = NavigationPath()
    }
}

