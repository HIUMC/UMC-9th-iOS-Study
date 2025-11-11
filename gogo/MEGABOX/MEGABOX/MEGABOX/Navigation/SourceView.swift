//
//  SourceView.swift
//  MEGABOX
//
//  Created by 고석현 on 10/2/25.
//
import Foundation
import SwiftUI

struct SourceView: View {
   
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
                    case .movieDetail(let movie):
                        MovieDetailView(movie: movie)
                            .navigationBarBackButtonHidden(true)
                    case .login:
                        TabBarView()
                            .navigationBarBackButtonHidden(true)
                    case .memberInfo:
                        InfoManageView()
                            .navigationBarBackButtonHidden(true)
                    }
                }
        }
    }
}

#Preview { SourceView() }
