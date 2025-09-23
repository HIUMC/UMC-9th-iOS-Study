//
//  ProfileView.swift
//  MegaBox
//
//  Created by 이서현 on 9/21/25.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("id") private var storedId: String = "Guest"
    
    var body: some View {
        VStack(spacing: 0) {
            headerView
                .padding(.top, 59)
                .padding(.bottom, 15)
            ClubMemberShipView
                .padding(.bottom, 33)
            CouponView
                .padding(.bottom, 33)
            OrderBar
            Spacer()
        }
        .padding(.horizontal, 16)
    }
    
    //MARK: - 헤더
    private var headerView: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text(storedId)
                    .font(.PretendardBold24)
                    .foregroundStyle(.black)
                    .padding(.trailing, 5)
                Text("WELCOME")
                    .font(.PretendardMedium14)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .foregroundStyle(.white)
                    .background(Color.tag)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                Spacer()
                Button(action: {
                }) {
                    Capsule()
                        .foregroundStyle(Color.gray07)
                        .frame(width: 72, height: 28)
                        .overlay(Text("회원정보")
                            .font(.PretendardSemiBold14)
                            .foregroundStyle(.white))
                }
            }
            HStack(spacing: 0) {
                Text("멤버십 포인트")
                    .font(.PretendardSemiBold14)
                    .foregroundStyle(.gray04)
                    .padding(.trailing, 9)
                Text("500P")
                    .font(.PretendardMedium14)
                    .foregroundStyle(.black)
                Spacer()
            }
            .padding(.top, 7)
        }
    }
    
    //MARK: - 멤버십
    private var ClubMemberShipView: some View {
        Button(action: {}) {
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 8)
                    .frame(maxWidth: .infinity)
                    .frame(height: 46)
                    .foregroundStyle(LinearGradient(
                        colors:
                            [Color.linearColor1,
                             Color.linearColor2,
                             Color.linearColor3],
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                HStack(alignment: .center, spacing: 3) {
                    Text("클럽 멤버십")
                        .font(.PretendardSemiBold16)
                        .foregroundStyle(.white)
                    Image(.chevronRight)
                        .frame(width: 10, height: 5)
                        .foregroundStyle(.white)
                    Spacer()
                }
                .padding(.leading, 8)
            }
        }
    }
    
    //MARK: - 쿠폰 / 스토어 교환권 / 모바일 티켓
    
    private var CouponView: some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                Text("쿠폰")
                    .font(.PretendardSemiBold16)
                    .foregroundStyle(.gray02)
                    .padding(.bottom, 9)
                Text("0")
                    .font(.PretendardSemiBold18)
                    .foregroundStyle(.black)
            }
            Spacer()
            Rectangle()
                .foregroundColor(.gray02)
                .frame(width: 1, height: 31)
            Spacer()
            
            VStack(spacing: 0) {
                Text("스토어 교환권")
                    .font(.PretendardSemiBold16)
                    .foregroundStyle(.gray02)
                    .lineLimit(1)
                    .padding(.bottom, 9)
                Text("0")
                    .font(.PretendardSemiBold18)
                    .foregroundStyle(.black)
            }
            Spacer()
            Rectangle()
                .foregroundColor(.gray02)
                .frame(width: 1, height: 31)
            Spacer()
            
            
            VStack(spacing: 0) {
                Text("모바일 티켓")
                    .font(.PretendardSemiBold16)
                    .foregroundStyle(.gray02)
                    .padding(.bottom, 9)
                Text("0")
                    .font(.PretendardSemiBold18)
                    .foregroundStyle(.black)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .background(Color.white)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 8,
                style: .continuous))
        .overlay(
            RoundedRectangle(
                cornerRadius: 8,
                style: .continuous
            )
                .stroke(Color.gray02, lineWidth: 0.5)
        )
        
        
    }
    
    //MARK: - 예매별 버튼
    private var OrderBar: some View {
        HStack(spacing: 0) {
            Button(action: {}) {
                VStack(spacing: 12) {
                    Image(.movieIcon)
                    Text("영화별예매")
                        .font(.PretendardMedium16)
                        .foregroundStyle(.black)
                }
            }
            Spacer()
            Button(action: {}) {
                VStack(spacing: 12) {
                    Image(.locationIcon)
                    Text("극장별예매")
                        .font(.PretendardMedium16)
                        .foregroundStyle(.black)
                }
            }
            Spacer()
            Button(action: {}) {
                VStack(spacing: 12) {
                    Image(.sofaIcon)
                    Text("특별관예매")
                        .font(.PretendardMedium16)
                        .foregroundStyle(.black)
                }
            }
            Spacer()
            Button(action: {}) {
                VStack(spacing: 12) {
                    Image(.orderIcon)
                    Text("모바일오더")
                        .font(.PretendardMedium16)
                        .foregroundStyle(.black)
                }
            }
        }
    }
    
    
    
    
}

#Preview {
    ProfileView()
}
