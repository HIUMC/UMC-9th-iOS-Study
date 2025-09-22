//
//  ProfileView.swift
//  week2_Practice
//
//  Created by 정승윤 on 9/21/25.
//

import SwiftUI

//struct ProfileView: View {
//    @EnvironmentObject var userViewModel: UserViewModel
//    
//    var body: some View {
//        VStack {
//            Text("프로필 화면")
//                .font(.largeTitle)
//            Text("사용자 이름: \(userViewModel.username)")
//                .font(.title)
//            
//            Button("이름 변경") {
//                userViewModel.username = "새로운 사용자"
//            }
//            .padding()
//            .background(Color.blue)
//            .foregroundStyle(.white)
//        }
//    }
//}

//#Preview {
//    ProfileView()
//        .environmentObject(UserViewModel())
//}

struct ProfileView: View {
    @Environment(UserViewModel.self) private var userViewModel
    
    var body: some View {
        VStack {
            Text("프로필 화면")
                .font(.largeTitle)
            
            Text("사용자 이름: \(userViewModel.username)")
                .font(.title)
            
            Button("이름 변경") {
                userViewModel.username = "새로운 사용자"
            }
            .padding()
            .background(Color.blue)
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    ProfileView()
        .environment(UserViewModel())
}


