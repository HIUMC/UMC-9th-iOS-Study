//
//  MemberInfoView.swift
//  MEGABOX
//
//  Created by 고석현 on 9/26/25.
//

import SwiftUI

//MARK: -헤더뷰
struct MemberInfoView: View {
    @AppStorage("userName") private var userName: String = "고석현"
    @AppStorage("userPoints") private var userPoints: Int = 500
    
    //MARK: -바디 뷰
    var body: some View {
        VStack(spacing: 16) {
            Spacer().frame(height:55)
            headerView
            clubMembershipButton
            Spacer().frame(height:5)
            statusInfoView
            Spacer().frame(height:3)
            bottomMenuView
            Spacer()
        }
        .padding(.horizontal)
    }
    
    //MARK: -이름 가운데 글자 마스킹
    //이름이 3글자가 아닌 경우도 고려함.
    var maskedUserName: String {
        guard userName.count >= 3 else { return userName + "님" }
        let firstChar = userName.prefix(1)
        let lastChar = userName.suffix(1)
        return "\(firstChar)*\(lastChar)님"
    }
    
    //MARK: -헤더 뷰
    private var headerView: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 8) {
                    Text(maskedUserName)
                        .font(.PretendardBold(size:24))
                    HStack(alignment: .center, spacing: 10) {
                        Text("WELCOME")
                            .font(
                                .PretendardMedium(size:14)
                            )
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                    }
                    .background(Color(red: 0.28, green: 0.8, blue: 0.82))
                    .cornerRadius(6)
                    Spacer()
                    Button(action: {
                        //TODO: - 회원정보 버튼 클릭 시 동작
                    }) {
                        HStack(alignment: .center, spacing: 0) {
                           
                            Text("회원정보")
                              .font(
                                Font.custom("Pretendard", size: 14)
                                  .weight(.semibold)
                              )
                              .multilineTextAlignment(.trailing)
                              .foregroundColor(.white)
                              .padding(.leading, 11)
                              .padding(.trailing, 12)
                              .padding(.vertical, 4)
                        }
                        //피그마 그대로 색상 가져옴
                        .background(Color(red: 0.28, green: 0.28, blue: 0.28))
                        .cornerRadius(16)
                    }
                }
                HStack(spacing: 2) {
                    Text("멤버십 포인트")
                        .font(.PretendardSemiBold(size:14))
                        .foregroundColor(.gray04)
                    Spacer().frame(width: 10)
                    Text("\(userPoints)P")
                        .font(.PretendardBold(size:14))
                     
                }
            }
            Spacer()
          
        }
    }
    
    //MARK: -클럽 멤버쉽 버튼
    private var clubMembershipButton: some View {
        Button(action: {
            //TODO: - 클럽 멤버쉽 버튼 클릭 시 동작
        }) {
            HStack {
                Spacer().frame(width:5)
                Text("클럽 멤버십")
                    .font(.PretendardSemiBold(size:16))
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(.white)
                Image("Vector")
                    
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height:45)
            .background(
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 0.67, green: 0.55, blue: 1), location: 0.00),
                        Gradient.Stop(color: Color(red: 0.56, green: 0.68, blue: 0.95), location: 0.53),
                        Gradient.Stop(color: Color(red: 0.36, green: 0.8, blue: 0.93), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0, y: 2),
                    endPoint: UnitPoint(x: 1, y: 2)
                )
            )
            
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .inset(by: 0.5)
                    .stroke(.black, lineWidth: 1)
            )
        }
    }
    
    //MARK: -상태정보 뷰
    //좀 기네.. 재사용할 수 있으면 좋았을텐데
    private var statusInfoView: some View {
        HStack {
            VStack(spacing: 6) {
                Text("쿠폰")
                    .font(.PretendardSemiBold(size: 16))
                    .foregroundColor(Color("gray02"))
                Text("2")
                    .font(.PretendardSemiBold(size: 18))
                    
            }
            .padding(.leading, 20)
            Spacer().frame(width:43)
            
            Rectangle()
                .foregroundColor(Color("gray02"))
                .frame(width: 1, height: 31)
            
            VStack(spacing: 6) {
                Text("스토어 교환권")
                    .font(.PretendardSemiBold(size: 16))
                    .foregroundColor(Color("gray02"))
                Text("0")
                    .font(.PretendardSemiBold(size: 18))
                    
            }
            .frame(maxWidth: .infinity)
            
            Rectangle()
                .foregroundColor(Color("gray02"))
                .frame(width: 1, height: 31)
            
            VStack(spacing: 6) {
                Text("모바일 티켓")
                    .font(.PretendardSemiBold(size: 16))
                    .foregroundColor(Color("gray02"))
                Text("0")
                    .font(.PretendardSemiBold(size: 18))
                    
            }
            .frame(maxWidth: .infinity)
        }
        .frame(height: 64)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color("gray02"), lineWidth: 1)
        )
    }
    
    //MARK: -하단 메뉴 뷰
    private var bottomMenuView: some View {
        HStack(alignment: .center) {
            VStack {
                Image("movie")
                Text("영화별예매")
                    .font(.PretendardMedium(size:16))
            }
            Spacer()
            VStack {
                Image("location")
                Text("극장별예매")
                    .font(.PretendardMedium(size:16))
            }
            Spacer()
            VStack {
                Image("seat")
                Text("특별관예매")
                    .font(.PretendardMedium(size:16))
            }
            Spacer()
            VStack {
                Image("popcorn")
                Text("모바일오더")
                    .font(.PretendardMedium(size:16))
            }
        }
        .padding(0)
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

//프리뷰 (과제용/아이폰 11, 16프로)
#Preview("iPhone 11") {
   LoginView()
}

#Preview("iPhone 16 Pro") {
 LoginView()
}



