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
        TabView(selection: $container.selectedTab){
            ForEach(TabItem.allCases, id: \.rawValue) { tab in
                Tab(
                    "",
                    image: container.selectedTab == tab ? "\(tab.rawValue)_fill" : "\(tab.rawValue)",
                    value: tab,
                    content: {
                        tabView(tab: tab)
                    }
                )
            }
        }
    }
    @ViewBuilder
    private func tabView(tab: TabItem) -> some View {
        Group {
            switch tab {
            case .home:
                HomeView(container: _container)
            case .booking:
                BookingView()
            case .order:
                OrderView()
            case .userinfo:
                UserInfoView(container:_container)
            }
        }
        .environmentObject(container)
    }
}


#Preview {
    BaseTabView()
        .environment(NavigationRouter())
        .environment(HomeViewModel())
}
