//
//  TabView.swift
//  week1_homework
//
//  Created by 정승윤 on 9/30/25.
//

import Foundation
import SwiftUI

struct MBTabView: View {
     
    var body: some View {
        TabView {
            Tab("홈", systemImage: "house.fill") {
                HomeView()
       
            }

            Tab("바로 예매", systemImage: "play.laptopcomputer") {
                Text("Sent View")
            }

            Tab("모바일 오더", systemImage: "popcorn") {
                Text("Account View")
            }
            
            Tab("마이 페이지", systemImage: "person") {
                UserInfoView()
                  }
        }
    }
}
// 그냥 탭뷰로 하니 충돌 남
#Preview {
    MBTabView()
        .environment(NavigationRouter())
        .environment(MovieViewModel())
}
