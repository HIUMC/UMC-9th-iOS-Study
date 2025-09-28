//
//  UserProfileView.swift
//  Megabox
//
//  Created by 김지우 on 9/24/25.
//

import SwiftUI

struct MemberInfoManageView: View {
    @Environment(\.dismiss) private var dismiss

    // AppStorage
    @AppStorage("idinfo")   private var userId: String = ""   // 로그인 시 저장된 아이디
    @AppStorage("userNameinfo") private var userName: String = ""

    // 편집 상태
    @State private var isEditingName: Bool = false
    @State private var tempName: String = ""


    var body: some View {
        VStack(alignment: .leading, spacing: 24) {

            // MARK: - 네비게이션 바 (HStack)
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 26, height: 22)
                        .foregroundStyle(.black)
                }

                Spacer()

                Text("회원정보 관리")
                    .font(.PretendardSemiBold(size: 16))
                    .foregroundStyle(.black01)

                Spacer()

                // 가운데 정렬을 위한 더미
                Color.clear
                    .frame(width: 20, height: 44)
            }
            .frame(height: 44)
            .padding(.top, 4)

            // MARK: - 섹션 제목
            Text("기본정보")
                .font(.PretendardRegular(size: 18))
                .foregroundStyle(.black)

            // MARK: - 아이디 (고정 텍스트)
            VStack(alignment: .leading, spacing: 8) {
                Text(userId)
                    .font(.PretendardRegular(size: 16))
                    .foregroundStyle(.black)

                Divider()
                    .foregroundStyle(.gray.opacity(0.4))
            }

            // MARK: - 이름 (텍스트/입력 + 변경/저장 버튼)
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    if isEditingName {
                        TextField("이름을 입력하세요", text: $tempName)
                            .textInputAutocapitalization(.words)
                            .autocorrectionDisabled()
                            .font(.PretendardRegular(size: 16))
                            .foregroundStyle(.black01)
                    } else {
                        Text(userName)
                            .font(.PretendardRegular(size: 16))
                            .foregroundStyle(.black)
                    }

                    Spacer(minLength: 16)

                    if isEditingName {
                        Button {
                            let newName = tempName.trimmingCharacters(in: .whitespacesAndNewlines)
                            userName = newName
                            isEditingName = false
                        } label: {
                            Text("저장")
                                .font(.system(size: 13, weight: .semibold))
                                .padding(.horizontal, 14)
                                .padding(.vertical, 6)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.black)
                                )
                                .foregroundStyle(.white)
                        }
                        .buttonStyle(.plain)
                    } else {
                        Button {
                            tempName = userName
                            isEditingName = true
                        } label: {
                            Text("변경")
                                .font(.system(size: 13, weight: .regular))
                                .foregroundStyle(.gray03)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(.gray03
                                            .opacity(0.6), lineWidth: 1)
                                )
                                .foregroundStyle(.black)
                        }
                        .buttonStyle(.plain)
                    }
                }

                Divider()
                    .foregroundStyle(.gray.opacity(0.4))
            }

            Spacer()
        }
        .padding(.horizontal, 16)
        .onAppear {
            // 진입 시 편집 버퍼 초기화
            tempName = userName
        }
    }
}

#Preview {
    MemberInfoManageView()
}
