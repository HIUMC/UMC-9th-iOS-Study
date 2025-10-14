//
//  RouterInstance.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/5/25.
//

import SwiftUI

struct ContentView: View {
    @State private var movieCard: MovieCardViewModel = .init()
    // 1. NavigationRouter 인스턴스를 @State로 생성
    @State private var router = NavigationRouter()
    
    var body: some View {
        // 2. NavigationStack의 path를 router의 path와 바인딩
        NavigationStack(path: $router.path) {
            // 시작 화면
            HomeView()
            
            // 3. Route enum 타입의 경로가 들어왔을 때 어떤 뷰를 보여줄지 정의
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
                }
            // 4. NavigationStack 전체에 router 인스턴스를 환경 객체로 주입
            // 이제 이 NavigationStack 내부의 모든 하위 뷰는 router에 접근 가능
                .environment(router)
        }
    }
}
