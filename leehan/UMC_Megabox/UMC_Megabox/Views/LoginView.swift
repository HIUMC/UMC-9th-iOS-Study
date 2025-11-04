//
//  LoginView.swift
//  UMC_Megabox
//
//  Created by OOng E on 9/16/25.
//

import SwiftUI
import Observation

struct LoginView: View {
    /* @AppStorage를 이용해 저장할 값 작성 */
    @AppStorage("id") private var id: String = ""
    @AppStorage("pwd") private var pwd: String = ""
    @State private var path = NavigationPath()
    /* @State를 이용해 LoginView에서 인스턴스 생성 */
    @State var viewModel = LoginViewModel()
    
    @Environment(AuthenticationManager.self) private var auth
    
    
    
    var body: some View {
            VStack {
                //Spacer().frame(height: 44)
                topGroup // '로그인' 텍스트
                Spacer()
                    .frame(height: 100)
                enterGroup // '아이디', '비밀번호'
                Spacer()
                    .frame(height: 75)
                loginBtn   // '로그인'
                Spacer()
                    .frame(height: 17)
                signupBtn // '회원가입'
                Spacer()
                    .frame(height: 35)
                socialLoginBtn // '네 카 애'
                Spacer()
                    .frame(height: 39)
                UMCadvertisement // 'UMC 홍보'
        }.padding(.horizontal)
    } // end of body
    
    private var topGroup: some View {
        HStack {
            Text("로그인")
                .font(.PretendardSemiBold(size: 24))
                .foregroundStyle(.black)
        }
    } // end of topGroup
    
    private var enterGroup: some View {
        
        /*
         VStack을 이용해 아이디와 비밀번호가 수직으로 배치되게 함
         텍스트 사이에 Divider()로 분리선 구현
        */
        VStack {
            
            /* $ 기호를 활용하여 Binding */
            /* TextField, SecureField는 Binding값을 요구함
             값을 "읽기"만 하는게 아니라 "쓰기"도 해야하기 때문 */
            TextField("아이디", text: $viewModel.loginModel.id)
            
            Divider()
                .frame(height: 1)
                .foregroundStyle(.gray02)
            
            
            Spacer()
                .frame(height: 40)
            
            /* 보안 입력을 위해 SecureField 사용 */
            SecureField("비밀번호", text: $viewModel.loginModel.pwd)
                
            Divider()
                .frame(height: 1)
                .foregroundStyle(.gray02)
        }
    } // end of enterGroup
    
    
    private var loginBtn: some View {
        /*
         로그인 버튼은 ZStack으로 배경을 만들어줌
         배경을 적절히 꾸미고 그 위에 텍스트 컴포넌트를 올려줌
         */
        Button(action: {
            if id == viewModel.loginModel.id && pwd == viewModel.loginModel.pwd {
                auth.login()
            }
        }) {
            ZStack {
                Rectangle()
                    .frame(height: 54)
                    .foregroundStyle(.purple03)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                Text("로그인")
                    .font(.PretendardBold(size: 18))
                    .foregroundStyle(.white)
            }
        }
        
        /*Button(action: { /* 아이디와 비밀번호 저장 */
            if (id == viewModel.loginModel.id && pwd == viewModel.loginModel.pwd) {
                
            } }) {
            ZStack {
                Rectangle()
                    .frame(height: 54)
                    .foregroundStyle(.purple03)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                Text("로그인")
                    .font(.PretendardBold(size: 18))
                    .foregroundStyle(.white)
            }
        }*/
    } // end of loginBtn
    
    
    private var signupBtn: some View {
        Button(action: {}) {
            Text("회원가입")
                .font(.PretendardMedium(size: 13))
                .foregroundStyle(.gray03)
        }
    } // end of signupBtn
    
    
    private var socialLoginBtn: some View {
        /*
         네 카 애 는 HStack으로 감싸고 사이에 Spacer()로 여백을 둠
         HStack 자체에 크기를 제한해 네 애 가 양쪽으로 밀착되는걸 막아줌
         */
        HStack {
            Spacer()
            
            Button(action: {}) {
                Image("icon_naver")
            }
            
            Spacer()
            
            Button(action: {}) {
                Image("icon_kakao")
            }
            
            Spacer()
            
            Button(action: {}) {
                Image("icon_apple")
            }
            
            Spacer()
        }
    } // end of socialLoginBtn
    
    private var UMCadvertisement: some View {
        Image("advertisement_umc")
            .resizable()
            .scaledToFit() // 원본 이미지 비율을 해치치 않으면서 화면에 맞게 조정
            .frame(height: 266)
    } //end of UMCadvertisement
}

#Preview {
    LoginView()
        .environment(AuthenticationManager())
}
