//
//  SettingVire.swift
//  week2_Practice
//
//  Created by 정승윤 on 9/21/25.
//

import SwiftUI

//struct SettingsView: View {
//    @EnvironmentObject var userViewModel: UserViewModel 
//
//    var body: some View {
//        VStack {
//            Text("설정 화면")
//                .font(.largeTitle)
//
//            TextField("사용자 이름 변경", text: $userViewModel.username)  // TextField로 직접 변경 가능
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//        }
//    }
//}
//
//#Preview {
//    SettingsView()
//        .environmentObject(UserViewModel())
//}

struct SettingViewContainer: View {
    @Environment(UserViewModel.self) private var userViewModel
    
    var body: some View {
        SettingsView(userViewModel: userViewModel)
    }
}

struct SettingsView: View {
    @Bindable var userViewModel: UserViewModel
    
    var body: some View {
        VStack {
            Text("설정 화면")
                .font(.largeTitle)
            
            TextField("사용자 이름 변경", text: $userViewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
        }
    }
}

#Preview {
    SettingsView(userViewModel: .init())
}
