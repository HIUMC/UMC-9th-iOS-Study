//
//  LoginView.swift
//  MEGABOX
//
//  Created by 박정환 on 9/17/25.
//

import SwiftUI

struct LoginView: View {
    @Environment(NavigationRouter.self) private var router
    @ObservedObject var viewModel: LoginViewModel = .init()
    
    @State private var userID: String = ""
    @State private var userPassword: String = ""

    private let keychain = KeychainService.shared
    
    var body: some View {
        VStack {
            navigationBar
            Spacer()

            InputSection
                .padding(.bottom, 75)

            LoginButton
                .padding(.bottom, 35)

            SocialLoginSection
                .padding(.bottom, 39)

            BannerSection
        }
        .padding(.horizontal, 16)
        .onAppear {
            if let savedID = keychain.read("userID") {
                viewModel.loginModel.id = savedID
            }
            if let savedPW = keychain.read("userPassword") {
                viewModel.loginModel.pwd = savedPW
            }
        }
    }

    private var navigationBar: some View {
        HStack{
            Text("로그인")
                .font(.semiBold24)
        }
    }
    
    private var InputSection: some View {
        VStack(alignment:.leading){

            TextField("아이디", text: $viewModel.loginModel.id)
                .font(.medium16)
                .foregroundColor(.gray03)
                .padding(.bottom, 4)

            Divider()
                .padding(.bottom, 40)

            SecureField("비밀번호", text: $viewModel.loginModel.pwd)
                .font(.medium16)
                .foregroundColor(.gray03)
                .padding(.bottom, 4)

            Divider()
        }
    }
    
    private var LoginButton: some View {
        VStack(alignment:.center) {
            Button(action: {
                // 입력한 값이 Keychain에 저장된 계정과 일치하는지 확인
                if let savedID = keychain.read("userID"),
                   let savedPW = keychain.read("userPassword"),
                   viewModel.loginModel.id == savedID,
                   viewModel.loginModel.pwd == savedPW {
                    print("로그인 성공!")
                    router.push(.login)
                } else {
                    print("아이디 또는 비밀번호가 일치하지 않습니다. (최초 로그인 시 저장)")
                    keychain.save(viewModel.loginModel.id, for: "userID")
                    keychain.save(viewModel.loginModel.pwd, for: "userPassword")
                    router.push(.login)
                }
            }) {
                Text("로그인")
                    .font(.bold18)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: 54)
                    .background(Color.purple03)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.bottom, 17)
            
            Button(action: {}) {
                Text("회원가입")
                    .font(.medium13)
                    .foregroundColor(.gray03)
            }
        }
    }
    
    private var SocialLoginSection: some View {
        HStack(spacing: 73) {
            Image("naverLogin")
            Image("kakaoLogin")
            Image("appleLogin")
        }
    }
    
    private var BannerSection: some View {
        Image("loginBanner")
            .resizable()
            .scaledToFit()
    }
    
    // func logout() {
    //     keychain.delete("userID")
    //     keychain.delete("userPassword")
    //     viewModel.loginModel.id = ""
    //     viewModel.loginModel.pwd = ""
    //     // Additional logout handling here
    // }
}

#Preview {
    LoginView()
        .environment(NavigationRouter())
}
