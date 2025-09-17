//
//  LoginView.swift
//  UMC_Megabox
//
//  Created by OOng E on 9/16/25.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        
        VStack {
            topGroup
            
            Spacer()
                .frame(height: 157)
            
            enterGroup
            
            Spacer()
                .frame(height: 75)
            loginBtn
            
            Spacer()
                .frame(height: 17)
            
            signupBtn
            
            Spacer()
                .frame(height: 35)
            
            socialLoginBtn
            
            Spacer()
                .frame(height: 39)
            
            UMCadvertisement
        }
        
    }
    
    private var topGroup: some View {
        HStack {
            Text("로그인")
                .font(.SemiBold24)
                .foregroundStyle(.black)
        }
    }
    
    private var enterGroup: some View {
        VStack {
            HStack {
                Text("아이디")
                    .font(.medium16)
                    .foregroundStyle(.gray03)
                Spacer()
            }.frame(width: 407)
            
            
            Divider()
                .frame(width: 407, height: 1)
                .foregroundStyle(.gray02)
            
            
            Spacer()
                .frame(height: 40)
            
            
            HStack {
                Text("비밀번호")
                    .font(.medium16)
                    .foregroundStyle(.gray03)
                Spacer()
            }.frame(width: 407)
            
            
            Divider()
                .frame(width: 407, height: 1)
                .foregroundStyle(.gray02)
        }
    }
    
    private var loginBtn: some View {
        Button(action: {}) {
            ZStack {
                Rectangle()
                    .frame(width: 407, height: 54)
                    .foregroundStyle(.purple03)
                    .clipShape(RoundedRectangle(cornerRadius: 13))
                Text("로그인")
                    .font(.Bold18)
                    .foregroundStyle(.white)
            }
        }
    }
    
    private var signupBtn: some View {
        Button(action: {}) {
            Text("회원가입")
                .font(.medium13)
                .foregroundStyle(.gray03)
        }
    }
    
    private var socialLoginBtn: some View {
        HStack {
            Button(action: {}) {
                Image("Naver")
            }
            
            Spacer()
            
            Button(action: {}) {
                Image("Kakao")
            }
            
            Spacer()
            
            Button(action: {}) {
                Image("Apple")
            }
        }.frame(width: 266)
    }
    
    private var UMCadvertisement: some View {
        
        Image("advertisement")
            .frame(width: 408, height: 266)
        
    }
    
}
        

#Preview {
    LoginView()
}
