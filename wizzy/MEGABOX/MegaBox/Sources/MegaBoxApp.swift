import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct MegaBoxApp: App {

    @State private var router = NavigationRouter()
    @StateObject private var viewModel = MovieViewModel()

    init() {

        if let appKey = Bundle.main.infoDictionary?["KAKAO_APP_KEY"] as? String {
            KakaoSDK.initSDK(appKey: appKey)
        } else {
            print("KAKAO_APP_KEY 가 안 보여요")
        }
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                MainView()
                    .environment(router)
                    .environmentObject(viewModel)
                    .onAppear {
                    }
            }
            .onOpenURL { url in
                print("OpenURL: \(url)")
                if AuthApi.isKakaoTalkLoginUrl(url) {
                    _ = AuthController.handleOpenUrl(url: url)
                }
            }
        }
    }
}
