//
//  UserInfoView.swift
//  MegaBox
//
//  Created by 박병선 on 9/23/25.
//
import SwiftUI

struct MemberInfoView: View, Hashable  {
    
    //Hashable 사용할 수 있도록 해주는 함수
    static func == (lhs: MemberInfoView, rhs: MemberInfoView) -> Bool { true }
        func hash(into hasher: inout Hasher) {}
    
    //MARK: -사용할 변수들
    // 로그인 시 저장된 아이디
    @AppStorage("userId") private var savedId: String = ""
    
    // 이름 저장
    @AppStorage("userName") private var savedName: String = ""
    
    // TextField 입력값 (수정용)
    @State private var tempName: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    //MARK: -body
    
    var body: some View {
        @Environment(NavigationRouter.self) var router
        VStack(alignment: .leading, spacing: 16) {
            // 네비게이션 헤더
            HStack {
                Button(action: {
                    // 뒤로가기 동작
                    router.pop()
                }) {
                    Image("left_bar")
                        .resizable()
                        .frame(width: 26, height: 24)
                }
                Spacer()
                
                Text("회원정보 관리")
                    .font(.pretendardMedium(16))
                Spacer()
                Spacer().frame(width: 24) // 오른쪽 여백 맞추기
            }
            .padding(.vertical, 8)
            
            // 기본정보 타이틀
            Text("기본정보")
                .font(.pretendardBold(18))
                .padding(.top, 20)
            
            // 아이디 (수정 불가)
            HStack {
                Text(savedId)
                    .foregroundStyle(.black00)
                Spacer()
            }
            .padding(.vertical, 12)
            .overlay(Rectangle().frame(height: 1).foregroundStyle(.gray02), alignment: .bottom)
            
            // 이름 (수정 가능)
            HStack {
                TextField("이름", text: $tempName)
                    .textFieldStyle(PlainTextFieldStyle())
                    .foregroundStyle(.black00)
                
                Spacer()
                
                Button("변경") {
                    savedName = tempName   // 이름 저장
                }
                .font(.pretendardMedium(10))
                .foregroundStyle(.gray03)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.6), lineWidth: 1)
                        )
            }
            .padding(.vertical, 12)
            .overlay(Rectangle().frame(height: 1).foregroundStyle(.gray02), alignment: .bottom)
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .onAppear {
            // 저장된 이름 불러오기
            tempName = savedName
        }
    }
}

//MARK: -프리뷰
#Preview {
    MemberInfoView()
}
