//
//  TabView.swift
//  MEGABOX
//
//  Created by 박정환 on 9/30/25.
//

import SwiftUI

struct BaseTabView: View {
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
                Text("")
            }
            
            Tab("모바일 오더", systemImage: "popcorn") {
                Text("프로필 화면")
            }
            
            Tab("마이 페이지", systemImage: "person") {
                MemberInfoView()
                    .environment(router)
                    .environment(viewModel)
            }
        }
    }
}

#Preview {
    BaseTabView()
        .environment(NavigationRouter())
        .environment(MovieViewModel())
}
