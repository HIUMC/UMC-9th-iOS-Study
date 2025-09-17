//
//  LoginView.swift
//  week1_homework
//
//  Created by 정승윤 on 9/15/25.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack{
            TopBanner
            
            Spacer()
            
            LoginInput
            
            SocialLogin
            
            
            UMCImage
                
        }.padding(.horizontal, 16)
    }
    private var TopBanner:some View {
        HStack{
            Text("로그인").font(.PretendardsemiBold24)
        }
    }
    private var LoginInput:some View {
        VStack{
            TextField("아이디", text: .constant("")) // constant: 임시값
                .padding(.bottom,4)
                .foregroundStyle(.gray03)
            Divider().foregroundStyle(.gray02)
            Spacer().frame(height: 40)
            TextField("비밀번호",text: .constant(""))
                .padding(.bottom,4)
                .foregroundStyle(.gray03)
            Divider().foregroundStyle(.gray02)
                .padding(.bottom,75)
            Button(action: {
                print("로그인 클릭")
            }
            ) {
                Text("로그인")
                    .frame(maxWidth:.infinity)
                    .frame(height: 54)
                    .font(.PretendardBold18)
                    .background(.purple03)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.bottom, 17)
                    
            }
              
            
            Text("회원가입").font(.Pretendardmedium13)
                .foregroundStyle(.gray04)
        }
    }
    private var SocialLogin:some View {
        HStack{
            Spacer()
            Image(.loginBtn)
           Spacer()
            Image(.loginBtn1)
            Spacer()
            Image(.loginBtn2)
            Spacer()
        }
        .padding(.top, 35)
        .padding(.bottom, 39)
    }
    private var UMCImage:some View {
        Image(.UMC)
            .resizable()
            .scaledToFit()
    }
}


struct Login_Preview: PreviewProvider {
    static var previews: some View {
        devicePreviews {
            LoginView()
        }
    }
}
