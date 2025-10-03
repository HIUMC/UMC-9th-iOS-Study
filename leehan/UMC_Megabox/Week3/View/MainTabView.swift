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
            Tab("홈", systemImage: "house.fill") {
                HomeView()
            }
            
            Tab("바로 예매", systemImage: "ticket.fill") {
                BookingView()
            }
            
            Tab("모바일 오더", systemImage: "popcorn.fill") {
                StoreView()
            }
            
            Tab("마이 페이지", systemImage: "person.fill") {
                UserInfoView()
            }
        }
    }
}

#Preview {
    MainTabView()
}
