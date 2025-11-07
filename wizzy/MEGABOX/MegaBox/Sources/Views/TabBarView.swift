//
//  TabView.swift
//  MegaBox
//
//  Created by 이서현 on 9/29/25.
//

import UIKit
import Foundation
import SwiftUI

struct TabBarView: View {
    @Environment(NavigationRouter.self) var router
    @EnvironmentObject var viewModel: MovieViewModel

    enum AppTab: Int {
        case home = 0
        case booking
        case order
        case profile
    }

    ///현재 선택된 탭을 추적
    @State private var selectedTab: AppTab

    ///초기 탭을 지정
    init(defaultTab: AppTab = .home) {
        _selectedTab = State(initialValue: defaultTab)
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("홈", systemImage: "house.fill", value: AppTab.home) {
                HomeView()
                    .environment(router)
                    .environmentObject(viewModel)
            }

            Tab("바로 예매", systemImage: "play.laptopcomputer", value: AppTab.booking) {
                BookingView()
                    .environment(router)
                    .environmentObject(viewModel)
            }

            Tab("모바일 오더", systemImage: "popcorn", value: AppTab.order) {
                EmptyView()
            }

            Tab("마이페이지", systemImage: "person", value: AppTab.profile) {
                ProfileView()
                    .environment(router)
                    .environmentObject(viewModel)
            }
        }
        .tint(.blue)
    }
}
