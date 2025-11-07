//
//  LoginView.swift
//  MegaBox
//
//  Created by 이서현 on 9/15/25.
//

import SwiftUI
import KakaoSDKUser
import KakaoSDKCommon

struct LoginView: View {
    @State private var isLoggedIn = false
    
    let keychain = KeychainService.shared
    let service = "MegaBox"
    
    @Environment(NavigationRouter.self) var router
    //@Environment(MovieViewModel.self) var movieViewModel
    
    @State var viewModel = LoginViewModel()
    private var id: String = ""
    private var pwd: String = ""
    
    @AppStorage("id") private var storedId: String = ""
    
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
        .onAppear {
            // 1) 저장된 아이디가 있고
            // 2) 아직 로그인 화면 위에 아무 것도 없을 때만
            if !storedId.isEmpty,
               let savedPwd = keychain.load(account: storedId, service: service),
               router.path.isEmpty {              //  이미 다른 화면으로 안 가 있는 경우에만

                viewModel.loginModel.id = storedId
                viewModel.loginModel.pwd = savedPwd

                DispatchQueue.main.async {
                    router.path.append(Route.tab(index: 0))
                }
            } else {
                print("저장된 로그인 정보 없음 - 로그인 화면 유지")
            }
        }
    }
    private var imageView: some View {
        Image(.umc1)
            .resizable()
            .aspectRatio(contentMode: .fit)
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
                // 여기서 바로 꺼내서 쓰기 (struct 프로퍼티에 대입 X)
                let id = viewModel.loginModel.id
                let pwd = viewModel.loginModel.pwd

                print("입력한 아이디: \(id), 비밀번호: \(pwd)")

                // 키체인에 저장
                keychain.savePasswordToKeychain(
                    account: id,
                    service: service,
                    password: pwd
                )
                storedId = viewModel.loginModel.id
                
                // 화면 이동
                router.path.append(Route.tab(index: 0))

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
            Button(action: { 
                if UserApi.isKakaoTalkLoginAvailable() {
                    UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                        if let error = error {
                            print("카카오톡 로그인 실패: \(error)")
                        } else {
                            print("카카오톡 로그인 성공")
                            // 로그인 성공 후 탭 화면으로 이동
                            router.path.append(Route.tab(index: 0))
                        }
                    }
                } else {
                    UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                        if let error = error {
                            print("카카오 계정 로그인 실패: \(error)")
                        } else {
                            print("카카오 계정 로그인 성공")
                            router.path.append(Route.tab(index: 0))
                        }
                    }
                }
            }) {
                Image(.kakaoButton)
                    .resizable()
                    .frame(width: 40, height: 40)
            }
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
        .environment(NavigationRouter())
}
