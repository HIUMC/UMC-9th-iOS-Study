//
//  MEGABOXApp.swift
//  MEGABOX
//
//  Created by 고석현 on 9/17/25.
//

import SwiftUI
@main
struct MegaBoxApp: App {
    @State private var router = NavigationRouter()
    @State private var viewModel = MovieViewModel()
    var body: some Scene {
        WindowGroup {
           
            SourceView()
                .environment(router)
                .environment(viewModel)
        }
    }
}
