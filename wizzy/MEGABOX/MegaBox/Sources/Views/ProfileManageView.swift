//
//  ProfileManageView.swift
//  MegaBox
//
//  Created by 이서현 on 9/21/25.
//

import SwiftUI

struct ProfileManageView: View {
    @AppStorage("id") private var storedId: String = "Guest"
    @AppStorage("name") private var storedName: String = "name"
    @Environment(\.dismiss) private var dismiss
    
    @State private var tempName: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView
                .padding(.bottom, 53)
            UserInfoView
            Spacer()
        }
        .padding(.horizontal, 16)
    }
    
    
    
    private var TopBarView: some View {
        HStack(alignment: .center, spacing: 0) {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "arrow.left")
                    .frame(width: 26, height: 22)
                    .padding(.trailing, 137)
                    .foregroundStyle(.black)
            }
            Text("회원정보 관리")
                .font(.PretendardMedium16)
                .foregroundStyle(.black)
                .padding(.vertical, 11)
            Spacer()
        }
    }
    
    //MARK: - 기본정보 뷰
    
    private var UserInfoView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("기본 정보")
                .font(.PretendardBold18)
                .padding(.bottom, 26)
            Text(storedId)
                .font(.PretendardMedium18)
                .foregroundStyle(.black)
            Divider()
                .foregroundStyle(.gray02)
                .padding(.top, 4)
                .padding(.bottom, 24)
            HStack(spacing: 0) {
                TextField("이름을 입력해주세요", text: $tempName)
                    .font(.PretendardMedium18)
                    .foregroundStyle(.black)
                Button(action: {
                    storedName = tempName //텍스트 필드에서의 입력값 저장
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: 38, height: 20)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.gray03, lineWidth: 1)
                                )
                            .foregroundStyle(.white)
                        Text("변경")
                            .foregroundStyle(.gray03)
                            .font(.PretendardMedium10)
                    }
                }
            }
            Divider()
                .foregroundStyle(.gray02)
                .padding(.top, 4)
                .padding(.bottom, 24)
            
        }
    }
    
}

#Preview {
    ProfileManageView()
}
