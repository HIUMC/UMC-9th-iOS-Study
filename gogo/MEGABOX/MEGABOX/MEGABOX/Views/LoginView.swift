//
//  LoginView.swift
//  MEGABOX
//
//  Created by 고석현 on 9/17/25.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            NavigationBarView()
                .padding(.bottom, 125)
            CredentialInputView()
                .padding(.bottom, 35)
            LoginButtonView()
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
                .font(.PretendardSemiBold24)
                .foregroundColor(.black)
            Spacer()
        }

    }
}

//MARK: -로그인 텍스트필드 하위뷰
struct CredentialInputView: View {
    var body: some View {
        VStack(alignment: .leading) {
            CredentialRowView(title: "아이디")
            CredentialRowView(title: "비밀번호")
        }
        .padding(.horizontal, 16)
    }
}

private struct CredentialRowView: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.PretendardMedium16)
            .foregroundColor(Color("gray03"))
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(
                Divider()
                    .frame(height: 1)
                    .background(Color("gray02")),
                alignment: .bottom
            )
            .padding(.bottom, 35)
    }
}

//MARK: - 로그인 버튼 하위뷰
struct LoginButtonView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Spacer()
            Text("로그인")
                .font(.PretendardBold18)
                .foregroundColor(.white)
            Spacer()
        }
       
        .padding(.vertical, 9)
        .frame(maxWidth: .infinity, minHeight: 54, maxHeight: 54, alignment: .center)
        .background(Color(red: 0.4, green: 0.05, blue: 0.85))
        .cornerRadius(10)
        .padding(.horizontal, 16)
    }
}

//MARK: -"회원가입" 텍스트 하위뷰
struct SignUpTextView: View {
    var body: some View {
        Text("회원가입")
            .font(.PretendardMedium13)
            .foregroundColor(Color("gray04"))
           
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
#Preview {
    LoginView()
}
