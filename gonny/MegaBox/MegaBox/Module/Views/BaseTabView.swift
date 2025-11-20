//
//  BaseTabView.swift
//  MegaBox
//
//  Created by 박병선 on 9/30/25.
//
import SwiftUI

struct BaseTabView: View {
    @Environment(NavigationRouter.self) var router
    
    var body: some View {
        TabView {
            HomeView(viewModel: HomeViewModel(), vm: MovieViewModel()).tabItem {
                Image(systemName: "house.fill" )
                Text("홈")
            }

            ReserveView().tabItem {
                Image(systemName: "ticket.fill" )
                Text("바로 예매")
            }

            MobileOrderView().tabItem {
                Image(systemName: "popcorn.fill" )
                Text("모바일 오더")
            }

            ProfileView().tabItem {
                Image(systemName: "person.fill" )
                Text("마이 페이지")
            }
        }
    }
}
