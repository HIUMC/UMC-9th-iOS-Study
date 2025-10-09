//
//  MegaboxApp.swift
//  Megabox
//
//  Created by 김지우 on 9/17/25.
//

import SwiftUI

@main
struct MegaboxApp: App {
    @StateObject private var container = DIContainer()

    var body: some Scene {
        WindowGroup {
            BaseTabView()
                .environmentObject(container)
            
        }
    }
}
