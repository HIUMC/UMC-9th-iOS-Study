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
            topGroup // '로그인' 텍스트
            Spacer()
                .frame(height: 157)
            enterGroup // '아이디', '비밀번호'
            Spacer()
                .frame(height: 75)
            loginBtn // '로그인'
            Spacer()
                .frame(height: 17)
            signupBtn // '회원가입'
            Spacer()
                .frame(height: 35)
            socialLoginBtn // '네 카 애'
            Spacer()
                .frame(height: 39)
            UMCadvertisement // 'UMC 홍보'
        }.padding() // 상화좌우 여백을 VStack에 Padding()으로 구현
                    // 기기가 바뀌어도 어느정도 비율 유지
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
         텍스트들은 HStack과 Spacer()를 활용헤 좌로 밀착
         텍스트 사이에 Divider()로 분리선 구현
        */
        VStack {
            HStack {
                Text("아이디")
                    .font(.PretendardMedium(size: 16))
                    .foregroundStyle(.gray03)
                Spacer()
            }
            
            
            Divider()
                .frame(height: 1)
                .foregroundStyle(.gray02)
            
            
            Spacer()
                .frame(height: 40)
            
            
            HStack {
                Text("비밀번호")
                    .font(.PretendardMedium(size: 16))
                    .foregroundStyle(.gray03)
                Spacer()
            }
            
            
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
        Button(action: {}) {
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
            
            Spacer()
        }
    } // end of socialLoginBtn
    
    private var UMCadvertisement: some View {
        Image("advertisement")
            .resizable()
            .scaledToFit() // 원본 이미지 비율을 해치치 않으면서 화면에 맞게 조정
            .frame(height: 266)
    } //end of UMCadvertisement
}

#Preview {
    LoginView()
}
