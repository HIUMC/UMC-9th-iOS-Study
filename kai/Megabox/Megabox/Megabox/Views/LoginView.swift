//
//  LoginView.swift
//  Megabox
//
//  Created by 김지우 on 9/18/25.
//

import SwiftUI

struct LoginView: View {
    @Bindable var loginviewModel : LoginViewModel
    
    @AppStorage("id") private var userID : String = ""
    @AppStorage("pwd") private var userPwd : String = ""
    
    init(loginviewModel: LoginViewModel) {
           self.loginviewModel = loginviewModel
       }
    
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
            TextField("아이디", text: $loginviewModel.loginModel.id)
                .font(.PretendardRegular(size: 16))
                .foregroundColor(.gray03)
                
            
            Divider()
                .offset(y:-3)
            
            Spacer().frame(height:40)
            
            SecureField("비밀번호", text: $loginviewModel.loginModel.pwd)
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
                userID = loginviewModel.loginModel.id
                userPwd = loginviewModel.loginModel.pwd
                
                        }) {
                    Text("로그인")
                        .font(.PretendardBold(size: 18))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, minHeight: 54)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.purple03))
                }
                .buttonStyle(.plain)
            //로그인 버튼 ZStack으로 구현 해도 됨 -> 이렇게 하면 center 정렬 더 정확하게 맞추어짐
            
            
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
                Image(.naverLogin)
            }
            Spacer()
            Spacer().frame(width:71)
            Button(action: {
                /*소셜로그인*/
            }) {
                Image(.kakaoLogin)
            }
            Spacer()
            Spacer().frame(width:71)
            Button(action: {
                /*소셜로그인*/
            }) {
                Image(.appleLogin)
            }
            Spacer().frame(width:71)
        }
    }
    
    //umc 포스터
    private var umcPoster: some View{
        Image(.umc)
            .resizable()
            .scaledToFit()
            .frame(height:266)
    }
    
        
}

#Preview {
    LoginView(loginviewModel: LoginViewModel())
}
