//
//  LoginView.swift
//  week1_homework
//
//  Created by 정승윤 on 9/15/25.
//

import SwiftUI
import Foundation


struct LoginView: View {
    @Environment(NavigationRouter.self) var router
    @Bindable var loginInput: LoginViewModel
    @AppStorage("idinfo") private var idinfo : String = ""
    @AppStorage("pwdinfo") private var pwdinfo : String = ""

    init(loginInput: LoginViewModel) {
        self.loginInput = loginInput
    }
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
            
        
    }
    
    private var TopBanner:some View {
        HStack{
            Text("로그인").font(.PretendardsemiBold24)
        }
    }
    
    private var LoginInput:some View {
     
        VStack{
            TextField("아이디", text: $loginInput.loginModel.id)
                .padding(.bottom,4)
                .foregroundStyle(.gray03)
            
            Divider().foregroundStyle(.gray02).frame(height:1)
            
            Spacer().frame(height: 40)
            
            SecureField("비밀번호",text: $loginInput.loginModel.pwd)
                .padding(.bottom,4)
                .foregroundStyle(.gray03)
            
            Divider().foregroundStyle(.gray02).frame(height:1)
            
            Spacer().frame(height:75)
            
            // AppStorage 저장 + 링크는 단순 링크로는 어려움
            Button(action: {
                self.idinfo = self.loginInput.loginModel.id
                self.pwdinfo = self.loginInput.loginModel.pwd
                router.push(.home)
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
                Image(.kakaoLogin)
                    .resizable()
                    .frame(width:40,height:40)
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
        devicePreviews {
            LoginView(loginInput: LoginViewModel())
                .environment(NavigationRouter())
            
        }
    }
}
