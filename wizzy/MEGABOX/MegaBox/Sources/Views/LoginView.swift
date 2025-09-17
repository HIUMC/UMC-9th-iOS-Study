//
//  LoginView.swift
//  MegaBox
//
//  Created by 이서현 on 9/15/25.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack(spacing: 0){
            TopBarView()
            Spacer()
            InputView()
            Spacer()
            LoginButton()
            Text("회원가입")
                .font(.PretendardMedium13)
                .foregroundStyle(Color.gray03)
                .padding(.top, 17)
            SNSButton()
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
}

struct TopBarView: View {
    var body: some View {
        HStack {
            Text("로그인")
                .font(.PretendardSemiBold24)
                .foregroundStyle(Color.black)
        }
    }
}

struct InputView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Group {
                Text("아이디")
                    .font(.PretendardMedium16)
                Divider()
                    .padding(.top, 4)
            }
            .foregroundStyle(Color.gray03)
            Spacer().frame(height: 41)
            
            Group {
                Text("비밀번호")
                    .font(.PretendardMedium16)
                Divider()
                    .padding(.top, 4)
            }
            .foregroundStyle(Color.gray03)
        }
    }
}

struct LoginButton: View {
    var body: some View {
        Button(action: {
            print("로그인 버튼 활성화")
        }) {
            Text("로그인")
                .font(.PretendardBold18)
                .frame(height: 54)
                .frame(maxWidth: .infinity)
                .background(Color.purple03)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}


struct SNSButton: View {
    var body: some View {
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
