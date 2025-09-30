//
//  MainTabView.swift
//  UMC_Megabox
//
//  Created by 이한결 on 9/30/25.
//

import SwiftUI

struct MainTabView: View {
    
    var body: some View {
        TabView {
            HomeView().tabItem {
                Image(systemName: "house.fill" )
                Text("홈")
            }
            
            BookingView().tabItem {
                Image(systemName: "ticket.fill" )
                Text("바로 예매")
            }
            
            StoreView().tabItem {
                Image(systemName: "popcorn.fill" )
                Text("모바일 오더")
            }
            
            UserInfoView().tabItem {
                Image(systemName: "person.fill" )
                Text("마이 페이지")
            }
            
            
        }
    }
}

#Preview {
    MainTabView()
}
