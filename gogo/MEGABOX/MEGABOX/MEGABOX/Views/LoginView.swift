//
//  LoginView.swift
//  MEGABOX
//
//  Created by 고석현 on 9/17/25.
//

import SwiftUI
import Observation


struct LoginView: View {
    @Environment(NavigationRouter.self) var router
    
    @State private var viewModel = LoginViewModel()
    @AppStorage("userId") private var storedId: String = ""
    @AppStorage("userPwd") private var storedPwd: String = ""
    var body: some View {
        VStack {
            navigationBarView
                .padding(.bottom, 125)
            loginInputView
                .padding(.bottom, 35)
            loginButtonView
                .padding(.bottom, 10)
            signUpTextView
                .padding(.bottom, 22)
            socialLoginView
                .padding(.bottom,22)
            umcBannerView
            Spacer()
        }
    }
    
    private var navigationBarView: some View {
        HStack {
            Spacer()
            Text("로그인")
                .font(.PretendardSemiBold(size:24))
                .foregroundStyle(.black)
            Spacer()
        }
    }
    
    private var loginInputView: some View {
        VStack(alignment: .leading, spacing: 35) {
            VStack(alignment: .leading, spacing: 0) {
                TextField("아이디", text: $viewModel.loginModel.id)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .font(.PretendardMedium(size:16))
                    .foregroundStyle(Color("gray03"))
                    .padding(.bottom, 8)
                    .overlay(
                        Divider()
                            .background(Color("gray02")),
                        alignment: .bottom
                    )
            }
            VStack(alignment: .leading, spacing: 0) {
                SecureField("비밀번호", text: $viewModel.loginModel.pwd)
                    .font(.PretendardMedium(size:16))
                    .foregroundStyle(Color("gray03"))
                    .padding(.bottom, 8)
                    .overlay(
                        Divider()
                            .background(Color("gray02")),
                        alignment: .bottom
                    )
            }
        }
        .padding(.horizontal, 16)
    }
    
    private var loginButtonView: some View {
        Button(action: {
            storedId = viewModel.loginModel.id
            storedPwd = viewModel.loginModel.pwd
            print("저장된 아이디: \(storedId), 저장된 비밀번호: \(storedPwd)")
                           router.path.append(Route.login)
        }) {
            HStack {
                Spacer()
                Text("로그인")
                    .font(.PretendardBold(size:18))
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding(.vertical, 9)
            .frame(maxWidth: .infinity, minHeight: 54, maxHeight: 54, alignment: .center)
            .background(Color(red: 0.4, green: 0.05, blue: 0.85))
            .cornerRadius(10)
            .padding(.horizontal, 16)
        }
    }
    
    private var signUpTextView: some View {
        Text("회원가입")
            .font(.PretendardMedium(size:13))
            .foregroundStyle(Color("gray04"))
    }
    
    private var socialLoginView: some View {
        HStack(spacing: 73) {
            Image("naverLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            Image("kakaoLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            Image("appleLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
        }
    }
    
    private var umcBannerView: some View {
        Image("umcBanner")
            .resizable()
            .scaledToFit()
            .padding(.horizontal, 16)
    }
    
  
    
}

//프리뷰 (과제용/아이폰 11, 16프로)
#Preview("iPhone 11") {
    LoginView()
           .environment(NavigationRouter())
}

#Preview("iPhone 16 Pro") {
    LoginView()
           .environment(NavigationRouter())
}
