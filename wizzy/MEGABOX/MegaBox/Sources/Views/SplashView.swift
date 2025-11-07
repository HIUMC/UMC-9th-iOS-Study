//
//  SplashView.swift
//  MegaBox
//
//  Created by 이서현 on 9/15/25.
//

import SwiftUI

struct SplashView: View {
    @Environment(NavigationRouter.self) var router
    @State private var isChecking = true
    @State private var didRunAutoLogin = false


    private let keychain = KeychainService.shared
    private let service = "MegaBox"

    @AppStorage("id") private var storedId: String = ""

    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(Color.white)

            Image(.megaboxLogo1)
                .resizable()
                .frame(width: 249, height: 84)
        }
        .onAppear {
            checkAutoLogin()
        }
    }

    private func checkAutoLogin() {
        // 앱 실행 시 키체인/스토리지 확인
        guard !didRunAutoLogin else { return }
        didRunAutoLogin = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // 1초 로고 노출
            if !storedId.isEmpty,
               let _ = keychain.load(account: storedId, service: service) {
                print("🔐 자동로그인 성공 - TabBarView로 이동")
                router.path.append(Route.tab(index: 0)) 
            } else {
                print("저장된 로그인 정보 없음 - Login화면으로 이동")
                router.path.append(Route.login)
            }
        }
    }
}

#Preview {
    SplashView()
        .environment(NavigationRouter())
}
