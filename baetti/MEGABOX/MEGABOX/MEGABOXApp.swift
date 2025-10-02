//
//  MEGABOXApp.swift
//  MEGABOX
//
//  Created by 박정환 on 9/17/25.
//

import SwiftUI

@main
struct MEGABOXApp: App {
    @State private var router = NavigationRouter()
    @State private var viewmodel = MovieViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                LoginView()
                    .environment(router)
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .home:
                            BaseTabView()
                                .navigationBarBackButtonHidden(true)
                        case .login:
                            BaseTabView()
                                .navigationBarBackButtonHidden(true)
                        case .profile:
                            MemberInfoManageView()
                                .navigationBarBackButtonHidden(true)
                        case .detail(let movie):
                            MovieDetailView(movie: movie)
                                .navigationBarBackButtonHidden(true)
                        }
                    }
            }
            .environment(router)
            .environment(viewmodel)
        }
    }
}
