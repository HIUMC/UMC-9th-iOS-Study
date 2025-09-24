//
//  LoginView.swift
//  MegaBox
//
//  Created by 박병선 on 9/16/25.
//
import SwiftUI

struct LoginView: View {
    //로그인 뷰모델에서 바인딩 받은 값
    @State private var viewModel = LoginViewModel()
       
 
    // 과제 요구: AppStorage에 아이디와 비밀번호 저장
    @AppStorage("userId") private var savedId: String = ""
    @AppStorage("userPwd") private var savedPwd: String = ""
    
    var body: some View {
        VStack(spacing: 24) {
    
            Text("로그인")
                .font(.pretendardSemiBold(24))
                .padding(.top, 10)
                .foregroundStyle(.black00)
            
            Spacer() //공간 분리
                
            VStack(spacing: 20) {
                TextField("아이디", text: $viewModel.loginModel.id)
                    .font(.pretendardMedium(16))
                    .foregroundStyle(.gray03)
                 
                
                Divider()


                SecureField("비밀번호", text: $viewModel.loginModel.pwd)
                    .font(.pretendardMedium(16))
                    .foregroundStyle(Color("gray03"))
                
                Divider()
            }
            .padding(.horizontal, 24)

            // 로그인 버튼
            Button(action: {
                savedId = viewModel.loginModel.id
                savedPwd = viewModel.loginModel.pwd
            }) {
                Image("login")
                    .resizable()
                    .frame(width: 380, height: 54)

            }
            .padding(.horizontal, 24)

          
            Button(action: {}) {
                Text("회원가입")
                    .foregroundStyle(Color("gray04"))
                    .font(.pretendardMedium(13))
            
            }

            // 소셜 로그인 버튼들
            HStack(spacing: 73) {
                //네이버 로그인
                Button(action: {
                        print("네이버 로그인")
                }){
                    Image("naverLogin")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                //카카오 로그인
                Button(action: {
                    print("카카오 로그인")
                }) {
                    Image("kakaoLogin")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                //애플 로그인
                Button(action: {
                    print("애플 로그인")
                }){
                    Image("appleLogin")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.black)
                }
            }
            .padding(.top, 8)

            // 하단 배너 이미지
            Image("umc")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 16)
            
            Spacer()
        }
        .background(Color.white.ignoresSafeArea())
    }
}

#Preview { //프리뷰
    LoginView()
}
