//
//  MegaboxApp.swift
//  Megabox
//
//  Created by 김지우 on 9/17/25.
//
import SwiftUI

@main
struct MegaboxApp: App {
    @StateObject private var container = DIContainer()
    
    var body: some Scene {
        WindowGroup {
            BaseTabView()
                .environmentObject(container)
        }
    }
}
    
/*
@main
struct MegaboxApp: App {
    
    // 1. AuthManager를 @State로 앱의 생명주기와 동일하게 생성합니다.
    //    (앱이 켜질 때 init()이 실행되며 자동 로그인을 시도합니다.)
    @State private var authManager = AuthManager()
    
    // 2. NavigationRouter도 여기서 생성합니다.
    @State private var router = NavigationRouter()
    
    var body: some Scene {
        WindowGroup {
            // 3. AuthManager의 인증 상태에 따라 뷰를 분기합니다.
            if authManager.isAuthenticated {
                // 4. (로그인 됨) 홈 화면 (예: MainTabView)을 보여줍니다.
                //    모든 하위 뷰가 authManager에 접근할 수 있도록 environment로 주입합니다.
                BaseTabView() 
                    .environment(authManager)
                    .environment(router)
                    .transition(.opacity.animation(.easeInOut)) // (선택) 부드러운 전환
            } else {
                // 5. (로그인 안 됨) 로그인 뷰를 보여줍니다.
                //    LoginView와 그 하위 뷰가 authManager에 접근할 수 있도록 주입합니다.
                NavigationStack(path: $router.path) {
                    LoginView() // LoginView는 ViewModel을 @State로 가짐
                }
                .environment(authManager)
                .environment(router)
                .transition(.opacity.animation(.easeInOut)) // (선택) 부드러운 전환
            }
        }
    }
}
*/
