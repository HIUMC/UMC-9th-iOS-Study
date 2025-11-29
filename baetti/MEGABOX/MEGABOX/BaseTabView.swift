//
//  TabView.swift
//  MEGABOX
//
//  Created by 박정환 on 9/30/25.
//

import SwiftUI

struct BaseTabView: View {
    var body: some View {
        TabView {
            Tab("홈", systemImage: "house.fill") {
                HomeView()
            }
            
            Tab("바로 예매", systemImage: "play.laptopcomputer") {
                ReservationView()
            }
            
            Tab("모바일 오더", systemImage: "popcorn") {
                MobileOrderView()
            }
            
            Tab("마이 페이지", systemImage: "person") {
                MemberInfoView()
            }
        }
    }
}

#Preview {
    BaseTabView()
        .environment(NavigationRouter())
        .environment(MovieViewModel())
        .environment(MobileOrderViewModel())
}
