//
//  MainTabView.swift
//  UMC_Megabox
//
//  Created by 이한결 on 9/30/25.
//

import SwiftUI

struct MainTabView: View {
    // State 변수로 라우터 생성
    @State private var router = NavigationRouter()
    @Environment(AuthenticationManager.self) private var auth
    
    var body: some View {
        
        NavigationStack {
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
        }.padding(.horizontal)
            .navigationDestination(for: Route.self) { route in
            switch route {
            case .login:
                LoginView()
                
            case .home:
                HomeView()
                
            case .detail(let movieCard):
                DetailedMovieCardView(movieCard: movieCard)
                
            case .booking:
                BookingView()
                
            case .store:
                StoreView()
                
            case .userInfo:
                UserInfoView()
            }
        }.environment(router)
        
    }
}

#Preview {
    MainTabView()
        .environment(AuthenticationManager())
}
