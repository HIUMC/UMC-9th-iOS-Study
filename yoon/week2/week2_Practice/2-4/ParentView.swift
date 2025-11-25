//
//  ParentView.swift
//  week2_Practice
//
//  Created by 정승윤 on 9/21/25.
//

import SwiftUI
//import Foundation
//
//struct ParentView: View {
//    @StateObject var userViewModel: UserViewModel = .init()
//    
//    var body: some View {
//        NavigationStack {
//            VStack {
//                Text("현재 사용자: \(userViewModel.username)").font(.title)
//                
//                NavigationLink("프로필 화면으로 이동", destination: ProfileView().environmentObject(userViewModel))
//                
//                NavigationLink("설정 화면으로 이동",
//                                               destination: SettingsView().environmentObject(userViewModel))
//            }
//        }
//    }
//}

struct ParentView: View {
    @State var userViewModel: UserViewModel = UserViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("현재 사용자: \(userViewModel.username)")
                                    .font(.title)

                                NavigationLink(
                                    "프로필 화면으로 이동",
                                    destination: ProfileView()
                                        .environment(userViewModel)
                                )
                                NavigationLink("설정 화면으로 이동",
                                               destination: SettingViewContainer().environment(userViewModel)
                                )
            }
        }
    }
}

#Preview {
    ParentView()
}
