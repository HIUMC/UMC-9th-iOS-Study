//
//  MegaBoxApp.swift
//  MegaBox
//
//  Created by 박병선 on 9/16/25.
//

import SwiftUI

@main
struct MegaBoxApp: App {
    @State private var router = NavigationRouter()

    @StateObject private var movieVM = MovieViewModel()
    @StateObject var auth = LoginViewModel()
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    
    var body: some Scene {
        WindowGroup {
            
            
            LoginView()
             .environmentObject(auth)
             .environmentObject(router)
             .environmentObject(movieVM)
            /*
            if auth.isLoggedIn {
                BaseTabView()
                    .environmentObject(auth)
                    .environmentObject(router)
                    .environmentObject(movieVM)
            } else {
                LoginView()
                    .environmentObject(auth)
                    .environmentObject(router)
                    .environmentObject(movieVM)
                
            }
              
            SplashView()
                .environmentObject(auth)
                .environmentObject(router)
                .environmentObject(movieVM)
             */
            

        }
    }
}
