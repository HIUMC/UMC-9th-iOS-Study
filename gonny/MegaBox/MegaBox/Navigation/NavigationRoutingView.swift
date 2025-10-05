//
//  NavigationRoutingView.swift
//  MegaBox
//
//  Created by 박병선 on 10/2/25.
//
import SwiftUI

struct NavigationRoutingView: View {
    @EnvironmentObject var container : DIContainer
    
    var body: some View{
        NavigationStack(path: $container.navigationRouter.path) {
            BaseTabView()
                .environmentObject(container)
                .navigationDestination(for: NavigationDestination.self) { route in
                    switch route {
                   /* case .home:
                        HomeView(container: container)
                    */
                    case .reserve:
                        ReserveView()
                    case .mobileOrder:
                        MobileOrderView()
                    case .memberInfo:
                        MemberInfoView()
                    /*
                     case .movieDetail:
                        MovieDetailView()
                    */
               
                    }
                }
        }
    }
}
