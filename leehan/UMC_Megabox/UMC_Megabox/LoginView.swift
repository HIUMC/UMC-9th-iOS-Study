//
//  LoginView.swift
//  UMC_Megabox
//
//  Created by OOng E on 9/16/25.
//

import SwiftUI


struct LoginView: View {
    var body: some View {
            
            GeometryReader { x in
                // x는 부모 뷰의 크기 전체
                
                let s = x.size.width / 440
                /*
                 아이폰 프로 맥스 16의 가로 크기를 이용해 다른 기기에서도
                 비슷한 컴포넌트 크기의 비율을 유지할 수 있도로 s 값을 선언
                */
               
                
                // 기존의 컴포넌트들에 s를 곱해 기기에 따라 비율 수정 가능하게 함
                VStack(alignment: .center) {
                    topGroup // '로그인' 텍스트
                    
                    Spacer()
                        .frame(height: 157 * s)
                    
                    enterGroup(s: s) // '아이디', '비밀번호'
                    
                    Spacer()
                        .frame(height: 75 * s)
                    
                    loginBtn(s: s) // '로그인'
                    
                    Spacer()
                        .frame(height: 17 * s)
                    
                    signupBtn // '회원가입'
                    
                    Spacer()
                        .frame(height: 35 * s)
                    
                    socialLoginBtn(s: s) // '네 카 애'
                    
                    Spacer()
                        .frame(height: 39 * s)
                    
                    UMCadvertisement(s: s) // 'UMC 홍보'
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            }
    }
    
    private var topGroup: some View {
        HStack {
            Text("로그인")
                .font(.SemiBold24)
                .foregroundStyle(.black)
        }
    }
    
    // s 값을 컴포넌트가 받아서 크기를 조절해주어야 하기 때문에 함수로 선언
    private func enterGroup(s: CGFloat) -> some View {
        
        /*
         VStack을 이용해 아이디와 비밀번호가 수직으로 배치되게 함
         텍스트들은 HStack과 Spacer()를 활용헤 좌로 밀착
         텍스트 사이에 Divider()로 분리선 구현
        */
        return VStack {
            HStack {
                Text("아이디")
                    .font(.medium16)
                    .foregroundStyle(.gray03)
                Spacer()
            }.frame(width: 407 * s)
            
            
            Divider()
                .frame(width: 407 * s, height: 1 * s)
                .foregroundStyle(.gray02)
            
            
            Spacer()
                .frame(height: 40 * s)
            
            
            HStack {
                Text("비밀번호")
                    .font(.medium16)
                    .foregroundStyle(.gray03)
                Spacer()
            }.frame(width: 407 * s)
            
            
            Divider()
                .frame(width: 407 * s, height: 1 * s)
                .foregroundStyle(.gray02)
        }
    }
    
    
    private func loginBtn(s: CGFloat) -> some View {
        /*
         로그인 버튼은 ZStack으로 배경을 만들어줌
         배경을 적절히 꾸미고 그 위에 텍스트 컴포넌트를 올려줌
         */
        return Button(action: {}) {
            ZStack {
                Rectangle()
                    .frame(width: 407 * s, height: 54 * s)
                    .foregroundStyle(.purple03)
                    .clipShape(RoundedRectangle(cornerRadius: 13 * s))
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
    
    
    private func socialLoginBtn(s: CGFloat) -> some View {
        /*
         네 카 애 는 HStack으로 감싸고 사이에 Spacer()로 여백을 둠
         HStack 자체에 크기를 제한해 네 애 가 양쪽으로 밀착되는걸 막아줌
         */
        return HStack {
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
        }.frame(width: 266 * s)
    }
    
    
    private func UMCadvertisement(s: CGFloat) -> some View {
        return Image("advertisement")
            .frame(width: 408 * s, height: 266 * s)
    }
    
}
        


#Preview {
    LoginView()
}
