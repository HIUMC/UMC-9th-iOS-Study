//
//  TabView.swift
//  MegaBox
//
//  Created by 이서현 on 9/29/25.
//

import SwiftUI

struct TabBarView: View {
    @Environment(NavigationRouter.self) var router
    @Environment(MovieViewModel.self) var viewModel
    
    var body: some View {
        TabView {
            Tab("홈", systemImage: "house.fill") {
                HomeView()
                    .environment(router)
                    .environment(viewModel)
            }
            
            Tab("바로 예매", systemImage: "play.laptopcomputer") {
                EmptyView()
            }
            
            Tab("모바일 오더", systemImage: "popcorn") {
                EmptyView()
            }
            
            
            Tab("마이페이지", systemImage: "person") {
                ProfileView()
                    .environment(router)
                    .environment(viewModel)
            }
        }
        .tint(.blue)
    }
}

#Preview {
    TabBarView()
        .environment(NavigationRouter())
        .environment(MovieViewModel())
}
