//
//  UserInfoView.swift
//  UMC_Megabox
//
//  Created by OOng E on 9/22/25.
//

import SwiftUI
import Foundation

struct UserInfoView: View {
    @AppStorage("name") private var name: String = ""
    
    @State var selectedImage: UIImage? = nil
    @State var showImagePicker: Bool = false
    @State var isPressing: Bool = false
    
    var body: some View {
        //NavigationStack {
            VStack {
                
                Spacer().frame(height: 103)
                
                topUserInfoGroup
                
                Spacer().frame(height: 15)
                
                clubMembershipBtn
                
                Spacer().frame(height: 33)
                
                stateInfo
                
                Spacer().frame(height: 33)
                
                bottomView
                
                Spacer().frame(height: 527)
            }.padding(.horizontal)
       // }
    }
    
    /* 상단 사용자 정보 */
    private var topUserInfoGroup: some View {
        
        HStack(spacing: 12) {
            // 프로필 이미지
            Group {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                } else {
                    Image("icon_profile")
                        .resizable()
                }
            }.scaleEffect(isPressing ? 0.9 : 1.0) // isPressing에 따라 애니메이션
                .animation(.easeInOut(duration: 0.2), value: isPressing) // 애니메이션에 딜레이
                // onLongPressGesture -> 누르는 시간 설정하여 동작할 수 있게 함
                .onLongPressGesture(minimumDuration: 1.0, pressing: { pressingState in
                self.isPressing = pressingState
                }) { // 1초를 채우면 이 코드가 실행
                showImagePicker = true
                }
                .sheet(isPresented: $showImagePicker) {
                ImagePicker(images: $selectedImage)
                }
                .frame(width: 55, height: 55)
                .scaledToFit()
                .clipShape(Circle())
            
            VStack {
                /* 상단 HStack */
                HStack {
                    /* ~~~ 님 */
                    Text("\(name)님")
                        .font(.PretendardBold(size: 24))
                    
                    /* WELCOME */
                    RoundedRectangle(cornerRadius: 6)
                        .foregroundStyle(.tag)
                        .frame(width: 81, height: 25)
                        .overlay(
                            Text("WELCOME")
                                .font(.PretendardMedium(size: 14))
                                .foregroundStyle(Color.white))
                    
                    Spacer()
                    
                    /* 회원정보 버튼 */
                    NavigationLink(destination: ManageUserInfoView()){
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundStyle(.gray07)
                            .frame(width: 72, height: 28)
                            .overlay(
                                Text("회원정보")
                                    .font(.PretendardSemiBold(size: 14))
                                    .foregroundStyle(.white))
                    }
                } // end of HStack
                
                /* 하단 HStack*/
                HStack {
                    /* 멤버십 포인트 */
                    Text("멤버십 포인트")
                        .font(.PretendardSemiBold(size: 14))
                        .foregroundStyle(.gray04)
                    
                    /* 500P */
                    Text("500P")
                        .font(.PretendardMedium(size: 14))
                        .foregroundStyle(.black)
                    
                    Spacer()
                } // end of HStack
            }.frame(height: 56) // end of VStack
        }
    }
    
    /* 클럽 멤버십 버튼 */
    private var clubMembershipBtn: some View {
        
        Button( action: {} ) {
            RoundedRectangle(cornerRadius: 8)
                .fill(LinearGradient(
                    stops: [
                    Gradient.Stop(color: Color(red: 0.67, green: 0.55, blue: 1), location: 0.00),
                    Gradient.Stop(color: Color(red: 0.56, green: 0.68, blue: 0.95), location: 0.53),
                    Gradient.Stop(color: Color(red: 0.36, green: 0.8, blue: 0.93), location: 1.00)
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                ))
                .frame(height: 46)
                .overlay(
                    HStack {
                        Text("클럽 멤버십")
                            .font(.PretendardSemiBold(size: 16))
                            .foregroundStyle(.white)
                            .padding(.leading, 8)
                        
                        Image(systemName: "chevron.right")
                            .foregroundStyle(Color.white)
                        
                        Spacer()
                    }
                )
            }
    }
    
    /* 상태 정보 뷰 */
    private var stateInfo: some View {
        
        RoundedRectangle(cornerRadius: 8)
        /* stroke 사용시 foregroundedStyle 수정자보다 먼저 작성 + import Foundation */
            .stroke(.gray02, lineWidth: 1)
            .foregroundStyle(Color.clear)
            .frame(height: 76)
            .overlay(
                HStack {
                    Spacer().frame(width: 24)
                    
                    VStack(spacing: 9) {
                        Text("쿠폰")
                            .font(.PretendardSemiBold(size: 16))
                            .foregroundStyle(.gray02)
                        
                        Text("2")
                            .font(.PretendardSemiBold(size: 18))
                            .foregroundStyle(.black)
                    }.frame(width: 28, height: 52) // end of VStack
                    /* Divider 좌우로 Spacer */
                    Spacer().frame(width: 43)
                    
                    /* HStack에서는 자동으로 세로 구분선 */
                    Divider().frame(height: 31)
                    
                    Spacer().frame(width: 43)
                    
                    VStack(spacing: 9) {
                        Text("스토어 교환권")
                            .font(.PretendardSemiBold(size: 16))
                            .foregroundStyle(.gray02)
                        
                        Text("0")
                            .font(.PretendardSemiBold(size: 18))
                            .foregroundStyle(.black)
                    }.frame(width: 87, height: 52) // end of VStack
                    
                    Spacer().frame(width: 43)
                    
                    Divider().frame(height: 31)
                    
                    Spacer().frame(width: 43)
                    
                    VStack(spacing: 9) {
                        Text("모바일 티켓")
                            .font(.PretendardSemiBold(size: 16))
                            .foregroundStyle(.gray02)
                        
                        Text("0")
                            .font(.PretendardSemiBold(size: 18))
                            .foregroundStyle(.black)
                    }.frame(width: 73, height: 52) // end of VStack
                    
                    Spacer().frame(width: 24)
                }) // end of HStack
    }
    
    /* 하단 뷰 */
    private var bottomView: some View {
        HStack {
            VStack {
                Image("icon_movie")
                    .resizable()
                    .scaledToFit()
                Spacer().frame(height: 12)
                Text("영화별예매")
                    .font(.PretendardMedium(size: 16))
                    .foregroundStyle(.black)
            }.frame(height: 67)
            
            Spacer()
            
            VStack {
                Image("icon_theater")
                    .resizable()
                    .scaledToFit()
                Spacer().frame(height: 12)
                Text("극장별예매")
                    .font(.PretendardMedium(size: 16))
                    .foregroundStyle(.black)
            }.frame(height: 67)
            
            Spacer()
            
            VStack {
                Image("icon_special")
                    .resizable()
                    .scaledToFit()
                Spacer().frame(height: 12)
                Text("특별관예매")
                    .font(.PretendardMedium(size: 16))
                    .foregroundStyle(.black)
            }.frame(height: 67)
            
            Spacer()
            
            VStack {
                Image("icon_mobile_order")
                    .resizable()
                    .scaledToFit()
                Spacer().frame(height: 12)
                Text("모바일오더")
                    .font(.PretendardMedium(size: 16))
                    .foregroundStyle(.black)
            }.frame(height: 67)
        }
    }
}


#Preview {
    UserInfoView()
}

