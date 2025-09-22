//
//  LoginView.swift
//  Megabox
//
//  Created by 김지우 on 9/18/25.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack{
            navigationBarTitle
            Spacer()
            idPasswordView
            Spacer().frame(height:74)
            loginButton
            Spacer().frame(height:35)
            socialLogin
            Spacer().frame(height:39)
            umcPoster
        }
        .padding()
    }
    
    //상단 네비게이션
    private var navigationBarTitle: some View {
        HStack(alignment: .center){
            Text("로그인")
                .font(.PretendardBold(size: 24))
        }//HStack_end
    }
    
    //아이디 비밀번호 입력칸
    private var idPasswordView: some View {
        VStack(alignment: .leading){
            Text("아이디")
                .font(.PretendardRegular(size: 16))
                .foregroundStyle(.gray03)
            Divider()
                .offset(y:-3)
            
            Spacer().frame(height:40)
            
            Text("비밀번호")
                .font(.PretendardRegular(size: 16))
                .foregroundStyle(.gray03)
            Divider()
                .offset(y:-3)
        }//VStack_end
        
    }
    
    private var loginButton: some View{
        VStack{
            RoundedRectangle(cornerRadius:10)
                .foregroundStyle(.purple03)
                .frame(height:54)
                .overlay(
                    Text("로그인") // 겹쳐 올릴 텍스트
                        .foregroundStyle(.white)
                        .font(.PretendardBold(size: 18)))
            //로그인 버튼 ZStack으로 구현 해도 됨 -> 이렇게 하면 center 정렬 더 정확하게 맞추어짐
            
            Spacer().frame(height:17)
            
            Text("회원가입")
                .foregroundStyle(.gray04)
                .font(.PretendardRegular(size: 13))
        }//VStack_end
    }
    
    private var socialLogin: some View{
        HStack{
            Spacer().frame(width:71)
            Image(.naverLogin)
            Spacer()
            Image(.kakaoLogin)
            Spacer()
            Image(.appleLogin)
            Spacer().frame(width:71)
        }
    }
    
    private var umcPoster: some View{
        Image(.umc)
            .resizable()
            .scaledToFit()
            .frame(height:266)
    }
    
        
}

#Preview {
    LoginView()
}
