//
//  UMC_MegaboxApp.swift
//  UMC_Megabox
//
//  Created by OOng E on 9/16/25.
//

import SwiftUI

@main
struct UMC_MegaboxApp: App {
    var body: some Scene {
        
        @State var auth = AuthenticationManager()
        
        
        WindowGroup {
                    // 2. 로그인 상태에 따라 보여주는 뷰를 결정
                    if auth.isAuthenticated {
                        //  로그인이 되었다면 MainTabView를 보여줌
                        MainTabView()
                            .environment(auth)
                    } else {
                        //  로그인이 안 되었다면 LoginView를 보여줌
                        LoginView()
                            .environment(auth)
                    }
                }
        
    }
}
