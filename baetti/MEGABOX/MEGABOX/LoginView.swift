//
//  LoginView.swift
//  MEGABOX
//
//  Created by 박정환 on 9/17/25.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            navigationBar
            Spacer()

            InputSection
                .padding(.bottom, 75)

            LoginButton
                .padding(.bottom, 35)

            SocialLoginSection
                .padding(.bottom, 39)

            BannerSection
        }
        .padding(.horizontal, 16)
    }

    private var navigationBar: some View {
        HStack{
            Text("로그인")
                .font(.semiBold24)
        }
    }
    
    private var InputSection: some View {
        VStack(alignment:.leading){
            
            Text("아이디")
                .font(.medium16)
                .foregroundColor(.gray03)
                .padding(.bottom, 4)
            
            Divider()
                .padding(.bottom, 40)
            
            Text("비밀번호")
                .font(.medium16)
                .foregroundColor(.gray03)
                .padding(.bottom, 4)
            Divider()
        }
    }
    
    private var LoginButton: some View {
        VStack(alignment:.center) {
            Button(action: {}) {
                Text("로그인")
                    .font(.bold18)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: 54)
                    .background(Color.purple03)
                    .cornerRadius(10)
            }
            .padding(.bottom, 17)
            
            Button(action: {}) {
                Text("회원가입")
                    .font(.medium13)
                    .foregroundColor(.gray03)
            }
        }
    }
    
    private var SocialLoginSection: some View {
        HStack(spacing: 73) {
            Image("naverLogin")
            Image("kakaoLogin")
            Image("appleLogin")
        }
    }
    
    private var BannerSection: some View {
        Image("loginBanner")
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

enum PREVIEW_DEVICE_TYPE : String, CaseIterable {
    case iPhone_16_Pro_Max = "iPhone 16 Pro Max"
    case iPhone_11 = "iPhone 11"
    
    var previewDevice: PreviewDevice {
        .init(rawValue: self.rawValue)
    }
}

func devicePreviews<Content: View>(
    content: @escaping () -> Content
) -> some View {
    ForEach(PREVIEW_DEVICE_TYPE.allCases, id: \.self) { device in
        content()
            .previewDevice(device.previewDevice)
            .previewDisplayName(device.rawValue)
    }
}

struct SwiftUIView_Preview: PreviewProvider {
    static var previews: some View {
        devicePreviews {
            LoginView()
        }
    }
}
