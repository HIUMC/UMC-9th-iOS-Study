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
    
    @AppStorage("id") var id: String = "1234"
    @AppStorage("pwd") var pwd: String = "1234"
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
                // 입력한 값이 미리 저장해둔 계정과 일치하는지 확인
                if viewModel.loginModel.id == id && viewModel.loginModel.pwd == pwd {
                    print("로그인 성공!")
                    // 여기서 화면 전환이나 상태 변경 처리 가능
                    router.push(.login)
                } else {
                    print("아이디 또는 비밀번호가 올바르지 않습니다.")
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
}

#Preview {
    LoginView()
        .environment(NavigationRouter())
}
