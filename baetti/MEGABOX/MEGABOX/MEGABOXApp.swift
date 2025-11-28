//
//  MEGABOXApp.swift
//  MEGABOX
//
//  Created by 박정환 on 9/17/25.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth


@main
struct MEGABOXApp: App {
    @State private var router = NavigationRouter()
    @State private var viewmodel = MovieViewModel()

    init() {
        let kakaoNativeAppKey = (Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] as? String) ?? ""
        KakaoSDK.initSDK(appKey: kakaoNativeAppKey)
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                LoginView()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .login:
                            BaseTabView()
                                .navigationBarBackButtonHidden(true)
                        case .profile:
                            MemberInfoManageView()
                                .navigationBarBackButtonHidden(true)
                        case .detail(let movie):
                            MovieDetailView(movie: movie)
                                .navigationBarBackButtonHidden(true)
                        case .mobileOrderDetail:
                            MobileOrderDetailView()
                                .navigationBarBackButtonHidden(true)
                        }
                    }
            }
            .environment(router)
            .environment(viewmodel)
            .environment(MobileOrderViewModel())
            .onOpenURL { url in
                if AuthApi.isKakaoTalkLoginUrl(url) {
                    // 카카오톡에서 다시 돌아왔을 때 처리를 정상적으로 완료하기 위해 사용
                    _ = AuthController.handleOpenUrl(url: url)
                }
            }
        }
    }
}
