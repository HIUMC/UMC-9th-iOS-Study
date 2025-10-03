//
//  TabBarView.swift
//  MEGABOX
//
//  Created by 고석현 on 10/2/25.
//

import SwiftUI

struct TabBarView: View {
//    @Environment(NavigationRouter.self) var router
//    @Environment(MovieViewModel.self) var viewModel

    var body: some View {
        TabView {
            //홈뷰
            Tab("홈", systemImage: "house.fill") {
                HomeView()
            }
            //예매뷰
            Tab("바로 예매", systemImage: "play.laptopcomputer") {
                EmptyView()
            }
            //모바일 오더 뷰
            Tab("모바일 오더", systemImage: "popcorn") {
                EmptyView()
            }
            //마이페이지 뷰
            Tab("마이페이지", systemImage: "person") {
                MemberInfoView()
            }
        }
       
        .tint(.blue)
      
    }
}

#Preview {
    TabBarView()
//        .environment(NavigationRouter())
//        .environment(MovieViewModel())
}
