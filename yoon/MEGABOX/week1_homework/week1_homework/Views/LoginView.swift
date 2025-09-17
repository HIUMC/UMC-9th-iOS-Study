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
            HStack{
                Text("로그인").font(.PretendardsemiBold24)
            }
            
            Spacer()
            
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
            }.padding(.bottom, 75)
            
            Button(action: {
                print("로그인 클릭")
            }
            ) {
                Text("로그인")
                    .frame(maxWidth:.infinity)
                    .font(.PretendardBold18)
                    .padding()
                    .background(.purple03)
                    .foregroundStyle(.white)
                    
            }.frame(height: 54)
                .cornerRadius(10)
                .padding(.bottom, 17)
            
            Text("회원가입").font(.Pretendardmedium13)
                .foregroundStyle(.gray04)
            
            HStack{
                Spacer()
                Image(.loginBtn)
               Spacer()
                Image(.loginBtn1)
                Spacer()
                Image(.loginBtn2)
                Spacer()
            }.padding(.top, 35)
                .padding(.bottom, 39)
            
            Image(.UMC).frame(height: 266)
                .frame(maxWidth: .infinity)
        }.padding(.horizontal, 16)
    }
}

struct Login_Preview: PreviewProvider {
    static var previews: some View {
        devicePreviews {
            LoginView()
        }
    }
}
