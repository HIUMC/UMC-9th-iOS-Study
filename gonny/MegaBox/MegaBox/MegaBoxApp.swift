//
//  MegaBoxApp.swift
//  MegaBox
//
//  Created by 박병선 on 9/16/25.
//

import SwiftUI

@main
struct MegaBoxApp: App {
    @State private var router = NavigationRouter()

    var body: some Scene {
        WindowGroup {
            LoginView()
                .environment(router)
        }
    }
}
