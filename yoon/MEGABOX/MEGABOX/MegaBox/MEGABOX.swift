//
//  week1_homeworkApp.swift
//  week1_homework
//
//  Created by 정승윤 on 9/15/25.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct MEGABOX: App {
    let theaterVM : TheaterViewModel = .init()
    @State var selectTheaters: Set<Theaters> = [.gangnam]
    @StateObject var loginVM = LoginViewModel()
    @StateObject var router = NavigationRouter()
    @StateObject var tmdbViewModel = TMDBViewModel()
    init() {
           // kakao sdk 초기화
           let kakaoNativeAppKey = (Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] as? String) ?? ""
           KakaoSDK.initSDK(appKey: kakaoNativeAppKey)
       }

    
    var body: some Scene {
        WindowGroup {
            if loginVM.isLoggedIn {
                PathView(selectTheaters: $selectTheaters)
                    .environmentObject(router)
                    .environmentObject(MovieViewModel())
                    .environmentObject(theaterVM)
                    .environmentObject(loginVM)
                    .environmentObject(tmdbViewModel) 
            } else {
                LoginView().onOpenURL(perform: { url in
                    if AuthApi.isKakaoTalkLoginUrl(url) {
                        AuthController.handleOpenUrl(url: url)
                    }
                })
                    .environmentObject(loginVM)
                    .environmentObject(router)
                    .environmentObject(tmdbViewModel)            }
// 여기에도 environment를 넣어줘야 하는구나.,.,, 깨달음 + 1
// 최상위계층에도 environment를 넣어줘야 하위 일반 뷰에서도 작동함
// 최상위를 패스뷰로 해 놔야 함. 로그인뷰로 해 놓으니까 로그인 뷰에서 넘어가질 않음 프리뷰 안넘어가는 것과 비슷한 느낌인 듯
        }
    }
}
