//
//  MainView.swift
//  MegaBox
//
//  Created by 이서현 on 9/30/25.
//

import Foundation
import SwiftUI

struct MainView: View {
    ///한 곳(MainView)에서 만든 객체를 앱 전체 화면에서 동일하게 쓰고 싶을 때
    @Environment(NavigationRouter.self) var router
    @EnvironmentObject var viewModel: MovieViewModel

    var body: some View {
        @Bindable var router = router
        
        NavigationStack(path: $router.path) {
            LoginView()
                .environment(router)
                .environmentObject(viewModel)
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .home:
                        HomeView()
                            .navigationBarBackButtonHidden(true)
                    case .detail(let movie):
                        MovieDetailView(movie: movie)
                            .navigationBarBackButtonHidden(true)
                    case .login:
                        TabBarView()
                            .navigationBarBackButtonHidden(true)
                    case .profile:
                        ProfileManageView()
                            .navigationBarBackButtonHidden(true)
                    }
                }
        }
    }
}

#Preview { MainView() }
