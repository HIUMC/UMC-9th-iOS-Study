//
//  TabView.swift
//  Megabox
//
//  Created by 김지우 on 10/2/25.
//

import SwiftUI

struct BaseTabView: View {
    @EnvironmentObject var container: DIContainer

    var body: some View {
        TabView(selection: $container.selectedTab) {
            // 홈
            HomeView()                                          //   _container 전달 제거
                .tabItem {
                    Label("홈", systemImage: "house.fill")       //   시스템 아이콘(Glass + 자동 틴트)
                }
                .tag(TabItem.home)                              //   태그 필수

            // 예매
            BookingView()
                .tabItem {
                    Label("예매", systemImage: "ticket.fill")
                }
                .tag(TabItem.booking)

            // 오더
            OrderView()
                .tabItem {
                    Label("오더", systemImage: "cup.and.saucer.fill")
                }
                .tag(TabItem.order)

            // 내 정보
            UserInfoView()                                      //   _container 전달 제거
                .tabItem {
                    Label("내 정보", systemImage: "person.crop.circle.fill")
                }
                .tag(TabItem.userinfo)
        }
        .tint(.purple)

        // iOS 기본 Glass(blur) 탭바 느낌 유지
        .toolbarBackground(.ultraThinMaterial, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
    }
}

#Preview {
    BaseTabView()
        .environmentObject(DIContainer())
}
