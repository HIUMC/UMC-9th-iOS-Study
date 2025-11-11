//
//  MemberInfoView.swift
//  MEGABOX
//
//  Created by 박정환 on 9/23/25.
//

import SwiftUI

struct MemberInfoView: View {
    @Environment(NavigationRouter.self) var router
    
    @AppStorage("nickname") private var nickname: String = ""
    
    var body: some View {
        VStack {
            MemberHeader
                .padding(.bottom, 15)
            
            ClubMembership
                .padding(.bottom, 33)
            
            CouponSummary
                .padding(.bottom, 33)
            
            ResevationMenu
            
            Spacer()
        }
        .padding(.horizontal, 14)
        .padding(.top, 103)
    }
    
    
    //상단 헤더
    private var MemberHeader: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0) {
                Text(nickname)
                    .font(.bold24)
                Text("님")
                    .font(.bold24)
                    .padding(.trailing, 5)
                
                Text("WELCOME")
                    .font(.medium14)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .fill(Color.tag)
                    )
                Spacer()
                
                Button {
                    // 회원정보 버튼 액션 자리
                    router.push(.profile)
                } label: {
                    Text("회원정보")
                        .font(.semiBold14)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 11)
                        .padding(.vertical, 4)
                        .background(Capsule().fill(Color.gray07))
                }
                .padding(.vertical, 6)
            }
            
            HStack {
                Text("멤버십 포인트")
                    .font(.semiBold14)
                    .foregroundColor(.gray04)
                Text("500P")
                    .font(.medium14)
                    .foregroundColor(.black)
                
                Spacer()
            }
        }
    }
    
    //클럽 멤버십 카드
    private var ClubMembership: some View {
        HStack {
            Text("클럽 멤버십")
                .font(.semiBold16)
                .foregroundColor(.white)
            Image(systemName: "chevron.right")
                .foregroundColor(.white)
            Spacer()
        }
        .padding(12)
        .background(
            LinearGradient(colors: [Color.purple.opacity(0.8), Color.blue.opacity(0.6)],
                           startPoint: .leading, endPoint: .trailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
    
    
    //쿠폰/교환권/티켓 요약
    private var CouponSummary: some View {
        HStack(spacing: 0) {
            VStack(spacing: 9) {
                Text("쿠폰")
                    .font(.semiBold16)
                    .foregroundColor(.gray02)
                Text("2")
                    .font(.semiBold18)
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity)
            
            Divider()
                .frame(height: 31)
            
            VStack(spacing: 9) {
                Text("스토어 교환권")
                    .font(.semiBold16)
                    .foregroundColor(.gray02)
                Text("0")
                    .font(.semiBold18)
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity)
            
            Divider()
                .frame(height: 31)
            
            VStack(spacing: 9) {
                Text("모바일 티켓")
                    .font(.semiBold16)
                    .foregroundColor(.gray02)
                Text("0")
                    .font(.semiBold18)
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

    //예약 메뉴
    private var ResevationMenu: some View {
        HStack(spacing: 0) {
            VStack {
                Button(action: {}) {
                    VStack {
                        Image("film")
                        Text("영화별예매")
                            .font(.medium16)
                            .foregroundColor(.black)
                            .padding(.top, 12)
                    }
                }
            }
            Spacer()
            
            VStack {
                Button(action: {}) {
                    VStack {
                        Image("mappin")
                        Text("극장별예매")
                            .font(.medium16)
                            .foregroundColor(.black)
                            .padding(.top, 12)
                    }
                }
            }
            Spacer()
            
            VStack {
                Button(action: {}) {
                    VStack {
                        Image("sofa")
                        Text("특별관예매")
                            .font(.medium16)
                            .foregroundColor(.black)
                            .padding(.top, 12)
                    }
                }
            }
            Spacer()
            
            VStack {
                Button(action: {}) {
                    VStack {
                        Image("popcorn")
                        Text("모바일오더")
                            .font(.medium16)
                            .foregroundColor(.black)
                            .padding(.top, 12)
                    }
                }
            }
        }
    }
    
}

#Preview {
    MemberInfoView()
        .environment(NavigationRouter())
}
