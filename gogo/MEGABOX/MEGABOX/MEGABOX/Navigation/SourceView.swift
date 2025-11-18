//
//  SourceView.swift
//  MEGABOX
//
//  Created by 고석현 on 10/2/25.
//
import Foundation
import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

struct SourceView: View {
   
    @Environment(NavigationRouter.self) var router
    @EnvironmentObject var viewModel: MovieViewModel
    @State private var isLoggedIn: Bool = false

    var body: some View {
        @Bindable var router = router

        NavigationStack(path: $router.path) {
            Group {
                if isLoggedIn {
                    TabBarView()
                        .navigationBarBackButtonHidden(true)
                } else {
                    LoginView(isLoggedIn: $isLoggedIn)
                        .environment(router)
                        .environmentObject(viewModel)
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .home:
                    HomeView()
                        .navigationBarBackButtonHidden(true)
                case .movieDetail(let movie):
                    MovieDetailView(movie: movie)
                        .navigationBarBackButtonHidden(true)
                case .login:
                    TabBarView()
                        .navigationBarBackButtonHidden(true)
                case .memberInfo:
                    InfoManageView(isLoggedIn: $isLoggedIn)
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
        .task {
            KakaoSDK.initSDK(appKey: Bundle.kakaoNativeAppKey)
        }
        .onOpenURL { url in
            if AuthApi.isKakaoTalkLoginUrl(url) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
        .onAppear {
            autoLoginCheck()
        }
    }
    
    
    private func autoLoginCheck() {
        let id = KeychainService.shared.read(KeychainService.Key.userID)
        let pw = KeychainService.shared.read(KeychainService.Key.userPassword)
        if id != nil && pw != nil {
            isLoggedIn = true
        }
    }
}


private extension Bundle {
    static var kakaoNativeAppKey: String {
        (Bundle.main.object(forInfoDictionaryKey: "KAKAO_NATIVE_APP_KEY") as? String) ?? ""
    }
}

#Preview { SourceView() }
