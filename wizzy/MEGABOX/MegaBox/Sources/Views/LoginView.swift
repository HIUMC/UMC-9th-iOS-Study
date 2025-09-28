//
//  LoginView.swift
//  MegaBox
//
//  Created by 이서현 on 9/15/25.
//

import SwiftUI

struct LoginView: View {
    
    @State var viewModel = LoginViewModel()
    @AppStorage("id") private var storedId: String = ""
    @AppStorage("pwd") private var storedPwd: String = ""
    
    
    var body: some View {
        VStack(spacing: 0){
            TopBarView
            Spacer()
            InputView
            Spacer()
            LoginBarView
            SNSButton
                .padding(.top, 35)
            imageView
                .padding(.top, 39)
                .padding(.bottom, 57)
            
            
            //Spacer()
        }
        .padding(.horizontal, 16)
    }
    
    private var imageView: some View {
        Image(.umc1)
            .resizable()
            .aspectRatio(contentMode: .fit)
        //FIXME: - 비율대로 최대한 넣고 싶은데 어떻게 해야할까
        //.frame(maxHeight: 206)
    }
    
    private var TopBarView: some View {
        HStack {
            Text("로그인")
                .font(.PretendardSemiBold24)
                .foregroundStyle(Color.black)
        }
    }
    
    private var InputView: some View {
        VStack(alignment: .leading, spacing: 0){
            Group {
                TextField("아이디", text: $viewModel.loginModel.id)
                    .font(.PretendardMedium16)
                Divider()
                    .padding(.top, 4)
            }
            .foregroundStyle(Color.gray03)
            Spacer().frame(height: 41)
            
            Group {
                SecureField("비밀번호", text: $viewModel.loginModel.pwd)
                    .font(.PretendardMedium16)
                Divider()
                    .padding(.top, 4)
            }
            .foregroundStyle(Color.gray03)
        }
    }
    
    private var LoginBarView: some View {
        VStack(spacing: 0) {
            Button(action: {
                storedId = viewModel.loginModel.id
                storedPwd = viewModel.loginModel.pwd
                print("저장된 아이디: \(storedId), 저장된 비밀번호: \(storedPwd)")
                
            }) {
                Text("로그인")
                    .font(.PretendardBold18)
                    .frame(height: 54)
                    .frame(maxWidth: .infinity)
                    .background(Color.purple03)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            Text("회원가입")
                .font(.PretendardMedium13)
                .foregroundStyle(Color.gray03)
                .padding(.top, 17)
        }
    }
    
    private var SNSButton: some View {
        HStack {
            Spacer()
            Image(.naverButton)
                .resizable()
                .frame(width: 40, height: 40)
            Spacer()
            Image(.kakaoButton)
                .resizable()
                .frame(width: 40, height: 40)
            Spacer()
            Image(.appleButton)
                .resizable()
                .frame(width: 40, height: 40)
            Spacer()
        }
    }
}


#Preview {
    LoginView()
}
