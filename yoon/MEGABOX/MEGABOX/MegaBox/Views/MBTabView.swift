//
//  TabView.swift
//  week1_homework
//
//  Created by 정승윤 on 9/30/25.
//

import Foundation
import SwiftUI

struct MBTabView: View {
    @ObservedObject var theaterVM: TheaterViewModel
    var body: some View {
        TabView {
            Tab("홈", systemImage: "house.fill") {
                HomeView()
       
            }

            Tab("바로 예매", systemImage: "play.laptopcomputer") {
                MovieBookView(theaterVM: theaterVM)
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
struct MBTabView_Preview: PreviewProvider {
    static var previews: some View {
        let theaterVM = TheaterViewModel()
        devicePreviews {
            
            MBTabView(theaterVM : theaterVM )
                .environment(NavigationRouter())
                .environment(MovieViewModel())
        }
    }
}
