//
//  LoginView.swift
//  Megabox
//
//  Created by 김지우 on 9/18/25.
//

import SwiftUI

struct LoginView: View {
    
    @State private var loginViewModel = LoginViewModel()
    
    @Environment(AuthManager.self) private var authManager
    @Environment(NavigationRouter.self) private var router
    
    var body: some View {
        VStack{
            Spacer().frame(height:44)
            navigationBarTitle
            Spacer().frame(height:125)
            
            idPasswordView
            
            Spacer().frame(height:35)
            loginButton
            Spacer().frame(height:17)
            signUpText
            Spacer().frame(height:35)
            socialLogin
            Spacer().frame(height:39)
            umcPoster
            Spacer()
        }
        .padding()
        .onOpenURL { url in
            // 카카오 로그인 콜백인지 확인
            let kakaoAppScheme = "kakao\(Config.kakaoNativeAppKey)"
            
            if url.scheme == kakaoAppScheme {
                
                // SFSafariViewController 닫기
                UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController?.dismiss(animated: true)
                
                // URL에서 "code=" 파라미터를 파싱
                if let authCode = loginViewModel.extractAuthorizationCode(from: url) {
                    loginViewModel.handleKakaoLogin(authCode: authCode, authManager: authManager)
                }
            }
        }
    }
    
    //상단 네비게이션
    private var navigationBarTitle: some View {
        HStack(alignment: .center){
            Text("로그인")
                .font(.PretendardSemiBold(size: 24))
        }//HStack_end
    }
    
    //아이디 비밀번호 입력칸
    private var idPasswordView: some View {
        VStack(alignment: .leading){
            TextField("아이디", text: $loginViewModel.loginModel.id)
                .font(.PretendardRegular(size: 16))
                .foregroundColor(.gray03)
            
            Divider()
                .offset(y:-3)
            
            Spacer().frame(height:40)
            
            SecureField("비밀번호", text: $loginViewModel.loginModel.pwd)
                .font(.PretendardRegular(size: 16))
                .foregroundColor(.gray03)
            Divider()
                .offset(y:-3)
            
            // (Part 1 요구사항: 마이페이지에 보일 이름)
            Spacer().frame(height:40)
            TextField("이름 (마이페이지 표시용)", text: $loginViewModel.loginModel.name)
                .font(.PretendardRegular(size: 16))
                .foregroundColor(.gray03)
            Divider()
                .offset(y:-3)
            
        }//VStack_end
        
    }
    
    //로그인버튼
    private var loginButton: some View{
        VStack{
            Button(action: {
                loginViewModel.handleStandardLogin(authManager: authManager)
            }) {
                Text("로그인")
                    .font(.PretendardBold(size: 18))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, minHeight: 54)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.purple03))
            }
            .buttonStyle(.plain)
            
        }//VStack_end
    }
    
    //회원가입
    private var signUpText : some View{
        Text("회원가입")
            .foregroundStyle(.gray04)
            .font(.PretendardRegular(size: 13))
    }
    
    //소셜로그인
    private var socialLogin: some View{
        HStack{
            
            Spacer().frame(width:71)
            Button(action: {
                /*소셜로그인*/
            }) {
                Image(.naverLogin) // 에셋 이름이 .naverLogin이라고 가정
            }
            Spacer()
            Spacer().frame(width:71)
            Button(action: {
                loginViewModel.openKakaoLogin()
            }) {
                Image(.kakaoLogin)
            }
            Spacer()
            Spacer().frame(width:71)
            Button(action: {
            }) {
                Image(.appleLogin)
            }
            Spacer().frame(width:71)
        }
    }
    
    //umc 포스터
    private var umcPoster: some View{
        Image(.umc) // 에셋 이름이 .umc라고 가정
            .resizable()
            .scaledToFit()
            .frame(height:266)
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
    .environment(AuthManager())
    .environment(NavigationRouter())
}
