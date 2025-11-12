//
//  LoginView.swift
//  MegaBox
//
//  Created by 박병선 on 9/16/25.
//
import SwiftUI

struct LoginView: View {
    // MARK: - 상태 관리
    @StateObject private var viewModel = LoginViewModel()
    private let kakaoLoginManager = KakaoLoginManager()
    // @State private var id: String = ""
    // @State private var pw: String = ""
        /// 로그인 상태
        @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
        
        /// 저장된 계정 정보
        @AppStorage("userId") private var savedId: String = ""
        @AppStorage("userPwd") private var savedPwd: String = ""
    
    //MARK: - 바디
    var body: some View {
        VStack(spacing: 24) {
    
            Text("로그인")
                .font(.pretendardSemiBold(24))
                .padding(.top, 10)
                .foregroundStyle(.black00)
            
            Spacer() //공간 분리
                
            ///입력 필드
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

            /// 로그인 버튼
            Button{
                loginAction()
            }label: {
                Image("login")
                    .resizable()
                    .frame(width: 380, height: 54)

            }
            .padding(.horizontal, 24)

          /// 회원가입 버튼
            Button(action: {
                print("회원가입 화면으로 이동")
            }) {
                Text("회원가입")
                    .foregroundStyle(Color("gray04"))
                    .font(.pretendardMedium(13))
            
            }

            /// 소셜 로그인 버튼들
            HStack(spacing: 73) {
                ///네이버 로그인
                Button(action: {
                        print("네이버 로그인")
                }){
                    Image("naverLogin")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                ///카카오 로그인
                Button(action: {
                    kakaoLoginManager.loginWithKakao()
                    print("카카오 로그인")
                }) {
                    Image("kakaoLogin")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                ///애플 로그인
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
        .fullScreenCover(isPresented: $isLoggedIn) {
                   BaseTabView() //  로그인 성공 시 전환
        }
        .onAppear {
                    // 앱 켰을 때 키체인에 있으면 자동 로그인
                    if viewModel.loadFromKeychainIfExists() {
                        isLoggedIn = true
                    }
                }
    }
    
    // MARK: - 로그인 동작
        private func loginAction() {
            // 입력 체크
            guard !viewModel.loginModel.id.isEmpty,
                  !viewModel.loginModel.pwd.isEmpty else {
                print("아이디 또는 비밀번호가 비어있습니다.")
                return
            }

            // 여기서 실제 서버 검증을 했다 치고 성공이라고 가정
            // Keychain에 저장
            viewModel.saveToKeychain()

            // 화면 전환
            isLoggedIn = true
        }
}


/*
#Preview { //프리뷰
    LoginView()
}
*/
