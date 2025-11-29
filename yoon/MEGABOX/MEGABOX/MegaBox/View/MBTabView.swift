//
//  TabView.swift
//  week1_homework
//
//  Created by 정승윤 on 9/30/25.
//

import Foundation
import SwiftUI

struct MBTabView: View {
    @Environment(TMDBViewModel.self) var tmdbViewModel
    @ObservedObject var theaterVM: TheaterViewModel
    @Binding var selectTheaters: Set<Theaters>
    var body: some View {
        TabView {
            Tab("홈", systemImage: "house.fill") {
                HomeView()
       
            }
            Tab("바로 예매", systemImage: "play.laptopcomputer") {
                MovieBookView(selectTheaters: $selectTheaters)
            }

            Tab("모바일 오더", systemImage: "popcorn") {
                MobileOrderView()
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
        let selectTheaters: Set<Theaters> = [.gangnam]
        let bindingSelect = Binding<Set<Theaters>>(
                    get: { selectTheaters },
                    set: { _ in } // preview에서는 값 변경 안 함
                )
        devicePreviews {
            
            MBTabView(theaterVM : theaterVM, selectTheaters: bindingSelect)
                .environmentObject(theaterVM)
                .environment(NavigationRouter())
                .environment(MovieViewModel())
        }
    }
}
