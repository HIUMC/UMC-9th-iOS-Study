//
//  LoginView.swift
//  MEGABOX
//
//  Created by 고석현 on 9/17/25.
//

import SwiftUI
import Observation


struct LoginView: View {
    @State private var viewModel = LoginViewModel()
    @AppStorage("userId") private var storedId: String = ""
    @AppStorage("userPwd") private var storedPwd: String = ""
    var body: some View {
        VStack {
            NavigationBarView()
                .padding(.bottom, 125)
            LoginInputView(viewModel: viewModel)
                .padding(.bottom, 35)
            LoginButtonView(viewModel: viewModel, storedId: $storedId, storedPwd: $storedPwd)
                .padding(.bottom, 10)
            SignUpTextView()
                .padding(.bottom, 22)
            SocialLoginView()
                .padding(.bottom,22)
            UmcBannerView()
            Spacer()
        }
    }
}

//MARK: -네비게이션 바 하위뷰
struct NavigationBarView: View {
    var body: some View {
        HStack {
            Spacer()
            Text("로그인")
                .font(.PretendardSemiBold(size:24))
                .foregroundStyle(.black)
            Spacer()
        }

    }
}

//MARK: -로그인 텍스트필드 하위뷰
struct LoginInputView: View {
    @Bindable var viewModel: LoginViewModel
    var body: some View {
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
}

//MARK: - 로그인 버튼 하위뷰
struct LoginButtonView: View {
    @Bindable var viewModel: LoginViewModel
    @Binding var storedId: String
    @Binding var storedPwd: String
    var body: some View {
        Button(action: {
            storedId = viewModel.loginModel.id
            storedPwd = viewModel.loginModel.pwd
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
}

//MARK: -"회원가입" 텍스트 하위뷰
struct SignUpTextView: View {
    var body: some View {
        Text("회원가입")
            .font(.PretendardMedium(size:13))
            .foregroundStyle(Color("gray04"))
           
    }
}

//MARK: -소셜 로그인 하위뷰
struct SocialLoginView: View {
    var body: some View {
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
}

//MARK: UMC 홍보 이미지 하위뷰
struct UmcBannerView: View {
    var body: some View {
        Image("umcBanner")
            .resizable()
            .scaledToFit()
            .padding(.horizontal, 16)
    }
    
  
    
}

//프리뷰 (과제용/아이폰 11, 16프로)
#Preview("iPhone 11") {
   LoginView()
}

#Preview("iPhone 16 Pro") {
 LoginView()
}
