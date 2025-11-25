//
//  UserInfoView.swift
//  week1_homework
//
//  Created by 정승윤 on 9/25/25.
//

import Foundation
import SwiftUI

struct UserInfoView: View {
    @EnvironmentObject var loginVM: LoginViewModel
    @Environment(NavigationRouter.self) var router
    var body: some View {
        
        VStack{
            Spacer().frame(height:59)
            
            ProfileHeader
            
            Spacer().frame(height:15)
            
            ClubMembership
            
            Spacer().frame(height:33)
            
            StatusInfo
            
            Spacer().frame(height:33)
            
            HStack{
                ResvItem(title: "영화별예매", iconImage: Image("film"))
                Spacer()
                ResvItem(title: "극장별예매", iconImage: Image("location"))
                Spacer()
                ResvItem(title: "특별관예매", iconImage: Image("chair"))
                Spacer()
                ResvItem(title: "모바일오더", iconImage: Image("popcorn"))
            }
            Spacer()
            Button(action:{loginVM.logout()}){Text("로그아웃")
                    .frame(width: 72)
                    .padding(.vertical, 4)
                .font(.PretendardsemiBold14)}
            .foregroundStyle(.white)
            .background(.gray07)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }.padding(.horizontal,16)
    }
        
        private var ProfileHeader:some View {
            VStack(alignment: .leading){
                HStack {
                    Text("\(loginVM.userName ?? "회원")님")
                        .font(.PretendardBold24)
                    
                    Text("WELCOME")
                        .padding(.horizontal, 8)
                        .padding(.vertical,4)
                        .font(.Pretendardmedium14)
                        .foregroundStyle(.white)
                        .background(.tag)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                    
                    Spacer()
                    
                    Button(action:{router.push(.userSetting)}){Text("회원정보")
                            .frame(width: 72)
                            .padding(.vertical, 4)
                        .font(.PretendardsemiBold14)}
                    .foregroundStyle(.white)
                    .background(.gray07)
                    .clipShape(RoundedRectangle(cornerRadius: 16))}
                
                // width, height 고정이면 frame으로 크기조정. padding X
                HStack(spacing: 9){
                    Text("멤버십 포인트")
                        .font(.PretendardsemiBold14)
                        .foregroundStyle(.gray04)
                    
                    Text("500P")
                        .font(.Pretendardmedium14)
                        .foregroundStyle(.black)
                }
            }
        }
        
        private var ClubMembership:some View {
            Button(action:{}){
                HStack(spacing:3){
                    Text("클럽 멤버십")
                        .font(.PretendardsemiBold16)
                        .foregroundStyle(.white)
                    
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.white)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical,12)
                .padding(.leading, 8)
                .padding(.trailing, )
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color("AB8BFF"), Color("8EAEF3"), Color("5DCCEC")]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ) // ColorAsset 등록 안하고 가능?
                )
            }.frame(height: 46)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        
        private var StatusInfo:some View {
            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray02,lineWidth: 1)
                    .frame(height: 76)
                
                HStack {
                    Spacer().frame(width:12)
                    VStack(spacing:9){
                        Text("쿠폰")
                            .font(.PretendardsemiBold16)
                            .foregroundStyle(.gray02)
                        Text("2")
                            .font(.PretendardsemiBold18)
                            .foregroundStyle(.black)
                    }.frame(width: 28)
                    Spacer()
                    Divider().frame(height:31)
                    Spacer()
                    VStack(spacing:9){
                        Text("스토어 교환권")
                            .font(.PretendardsemiBold16)
                            .foregroundStyle(.gray02)
                        Text("0")
                            .font(.PretendardsemiBold18)
                            .foregroundStyle(.black)
                    }.frame(width: 87)
                    Spacer()
                    Divider().frame(height:31)
                    Spacer()
                    VStack(spacing:9){
                        Text("모바일 티켓")
                            .font(.PretendardsemiBold16)
                            .foregroundStyle(.gray02)
                        Text("0")
                            .font(.PretendardsemiBold18)
                            .foregroundStyle(.black)
                    }.frame(width: 73)
                    Spacer().frame(width:12)
                }.frame(height:76)
                
            }
            // 스택에 background 쓰면 안댐 (deprecated)
            // ()로 묶으면 deprecated, {}로 묶으면 사용 가능?
            
        }
        
        struct ResvItem: View {
            let title: String
            let iconImage: Image
            var body: some View {
                VStack(spacing:12){
                    iconImage
                        .resizable()
                        .frame(width:36,height:36)
                    Text(title)
                        .font(.Pretendardmedium16)
                    
                }
            }
        }
    }

struct UserInfo_Preview: PreviewProvider {
    static var previews: some View {
        devicePreviews {
            UserInfoView()
                .environment(NavigationRouter())
                .environment(MovieViewModel())
        }
    }
}
