//
//  MemberInfoManageView.swift
//  MEGABOX
//
//  Created by 박정환 on 9/23/25.
//

import SwiftUI

struct MemberInfoManageView: View {
    @Environment(\.dismiss) private var dismiss
    
    @AppStorage("id") private var id: String = ""
    @AppStorage("nickname") private var nickname: String = ""
    @State private var changeName: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            NavigationBar
                .padding(.bottom, 53)
            BasicInfo
            AccountInfoSection
            
            Spacer()
        }
        .padding(.horizontal, 16)
    }
    
    /// 상단 네비게이션 바
    private var NavigationBar: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image("leading")
            }
            Spacer()
            Text("회원정보 관리")
                .font(.medium16)
            Spacer()
            Color.clear.frame(width: 18, height: 18)
        }
    }

    /// 기본정보
    private var BasicInfo: some View {
        Text("기본정보")
            .font(.bold18)
    }

    /// 회원 아이디 / 이름 섹션
    private var AccountInfoSection: some View {
        VStack(spacing: 0) {
            // 아이디
            HStack {
                Text(id)
                    .font(.medium18)
                Spacer()
            }
            .padding(.bottom, 5)
            
            Divider()
                .padding(.bottom, 24)
            
            // 이름 + 변경 버튼
            HStack {
                TextField("", text: $changeName)
                    .font(.medium18)
                    .foregroundStyle(.black)
                Button(action: {
                    nickname = changeName
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gray03, lineWidth: 1)
                            .frame(width: 38, height: 20)
                        
                        Text("변경")
                            .foregroundStyle(.gray03)
                            .font(.medium10)
                    }
                }
            }
            .padding(.bottom, 5)
            
            Divider()
        }
        .onAppear { changeName = nickname }
    }
}


#Preview {
    MemberInfoManageView()
}
