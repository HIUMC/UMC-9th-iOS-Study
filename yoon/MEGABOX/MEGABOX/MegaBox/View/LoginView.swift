//
//  LoginView.swift
//  week1_homework
//
//  Created by 정승윤 on 9/15/25.
//

import SwiftUI
import Foundation


struct LoginView: View {
    @EnvironmentObject var router: NavigationRouter
    @EnvironmentObject var loginVM: LoginViewModel
    @StateObject private var kakaoLogin = KakaoLoginService()
    // 초깃값을 LoginViewModel의 초깃값으로 설정
    var body: some View {

            VStack{
                TopBanner
                 
                Spacer().frame(height: 157)
                
                LoginInput
                
                Spacer().frame(height: 35)
                
                SocialLogin
                
                Spacer().frame(height: 39)
                
                UMCImage
            }.padding(.horizontal,16)
            .onAppear {
                loginVM.autoLogin()
    }
    }
    
    private var TopBanner:some View {
        HStack{
            Text("로그인").font(.PretendardsemiBold24)
        }
    }
    
    private var LoginInput:some View {
     
        VStack{
            TextField("아이디", text: $loginVM.loginModel.id)
                .padding(.bottom,4)
                .foregroundStyle(.gray03)
            
            Divider().foregroundStyle(.gray02).frame(height:1)
            
            Spacer().frame(height: 40)
            
            SecureField("비밀번호",text: $loginVM.loginModel.pwd)
                .padding(.bottom,4)
                .foregroundStyle(.gray03)
            
            Divider().foregroundStyle(.gray02).frame(height:1)
            
            Spacer().frame(height:75)
            
            // AppStorage 저장 + 링크는 단순 링크로는 어려움
            Button(action: {
                loginVM.login()
            }
            ) {
                Text("로그인")
                    .frame(maxWidth:.infinity)
                    .frame(height: 54)
                    .font(.PretendardBold18)
                    .background(.purple03)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            Spacer().frame(height:17)
            
            Text("회원가입").font(.Pretendardmedium13)
                .foregroundStyle(.gray04)
            
        }
    }
    
    private var SocialLogin:some View {
        HStack{
            Spacer().frame(width:71)
            Button(action:{
                kakaoLogin.kakaoLogin()
                
            }){
                Image(.kakaoLogin)
                    .resizable()
                    .frame(width:40,height:40)
            }
            Spacer()
            Image(.appleLogin)
                .resizable()
                .frame(width:40,height:40)
            Spacer()
            Image(.naverLogin)
                .resizable()
                .frame(width:40,height:40)
            Spacer().frame(width:71)
        }
            
    }
        
    private var UMCImage:some View {
        Image(.UMC)
            .resizable()
            .scaledToFit()
    }
    
    
    }

struct Login_Preview: PreviewProvider {
        static var previews: some View {
            let loginVM = LoginViewModel()
            let router = NavigationRouter()
            
            LoginView()
                .environmentObject(loginVM)
                .environmentObject(router)
        }
    }
