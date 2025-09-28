//
//  UserInfoView.swift
//  Megabox
//
//  Created by 김지우 on 9/24/25.
//

import SwiftUI

struct UserInfoView: View {
    @AppStorage("id") var userID: String = ""
    @AppStorage("pwd") var userPwd: String = ""
    @AppStorage("name") var userName: String = ""


    var body: some View {
        VStack{
            Spacer().frame(height:70)
            userInfo
            Spacer().frame(height:15)
            clubMembership
            Spacer().frame(height:33)
            CouponState
            Spacer().frame(height:33)
            InfoIcons()
            Spacer()

        }
        .padding(.horizontal,14)
    }
        
    
    //회원정보 헤더
    private var userInfo: some View{
        VStack(alignment: .leading){
            //이름,welcome,회원정보
            HStack{
                Text("\(userName)님")
                .font(.PretendardBold(size: 24))
                .padding(.trailing, 3)
                
                RoundedRectangle(cornerRadius:6)
                    .frame(width:81,height:25)
                    .foregroundStyle(.tag)
                    .overlay(
                        Text("WELCOME")
                            .font(.PretendardRegular(size: 14))
                            .foregroundStyle(.white01))
                
                Spacer()
                    
                 
                Button(action: { /* 회원정보 액션 */ }) {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width:72,height:28)
                        .foregroundStyle(.gray07)
                        .overlay(
                            Text("회원정보")
                                .font(.PretendardRegular(size: 14))
                                .foregroundStyle(.white01))
                    }
                 
            }//HStack_end
                
            //멤버십 포인트
                HStack{
                    Text("멤버십 포인트")
                        .font(.PretendardRegular(size: 14))
                        .foregroundStyle(.gray04)

                    Text("500P")
                        .font(.PretendardRegular(size: 14))
                        .foregroundStyle(.black01)
                }//HStack_end
                
        }//VStack_end
    }
    
    private var clubMembership: some View{
        Button(action:{/* 회원정보 액션 */}){
                RoundedRectangle(cornerRadius: 8)
                    .fill(
                        LinearGradient(colors: [.gradient1, .gradient2,.gradient3],
                                       startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .frame(height:46)
                    .overlay(
                        HStack {
                            Spacer()
                                .frame(width:8)
                                    Text("클럽 멤버십")
                                .font(.PretendardRegular(size: 14))
                                        .foregroundColor(.white)
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.white)
                                    Spacer()
                                })
                
        }
    }
    
    private var CouponState: some View{
        HStack(spacing: 0) {
                   VStack(spacing: 9) {
                       Text("쿠폰")
                           .font(.PretendardSemiBold(size: 16))
                           .foregroundColor(.gray02)
                       Text("2")
                           .font(.PretendardSemiBold(size: 18))
                           .foregroundColor(.black)
                   }
                   .frame(maxWidth: .infinity)

                   Divider()
                       .frame(height: 31)

                   VStack(spacing: 9) {
                       Text("스토어 교환권")
                           .font(.PretendardSemiBold(size: 16))
                           .foregroundColor(.gray02)
                       Text("0")
                           .font(.PretendardSemiBold(size: 18))
                           .foregroundColor(.black)
                   }
                   .frame(maxWidth: .infinity)

                   Divider()
                       .frame(height: 31)


                   VStack(spacing: 9) {
                       Text("모바일 티켓")
                           .font(.PretendardSemiBold(size: 16))
                           .foregroundColor(.gray02)
                       Text("0")
                           .font(.PretendardSemiBold(size: 18))
                           .foregroundColor(.black)
                   }
                   .frame(maxWidth: .infinity)
                   .frame(height: 76)
               }
               .overlay(
                   RoundedRectangle(cornerRadius: 8)
                       .stroke(Color.gray02)
               )
    }
}

struct InfoMenuCard: View {
    let icon: String
    let label: String
    var action: () -> Void = {}

    private let iconSize: CGFloat = 36  // 🔧 Figma 아이콘 크기에 맞춰 조절

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(icon)                       // 에셋 이미지 사용
                    .resizable()
                    .scaledToFit()
                    .frame(width: iconSize, height: iconSize)

                Text(label)
                    .font(.PretendardSemiBold(size: 13))   // 선언형 폰트
                    .foregroundStyle(Color.black)          // 선언형 색상
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity) // 그리드 칼럼 꽉 채우기
            .padding(.vertical, 6)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

struct InfoIcons : View{
    @State private var infoviewModel = InfoViewModel()

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 4)

    var body: some View {
        LazyVGrid(columns: columns, alignment: .center, spacing: 0) {
            ForEach(infoviewModel.infoModel) { item in
                InfoMenuCard(icon: item.icon, label: item.label) {
                    // TODO: 탭 액션 (네비게이션/시트 등)
                }
            }
        }
    }
}
#Preview {
    UserInfoView()
}
