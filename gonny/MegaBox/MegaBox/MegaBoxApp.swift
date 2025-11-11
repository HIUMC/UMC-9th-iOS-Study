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
    @StateObject private var movieVM = MovieViewModel()

    var body: some Scene {
        WindowGroup {
            ReserveView()
                .environmentObject(movieVM)
                .environment(router)
        }
    }
}
