//
//  ManageUserInfo.swift
//  UMC_Megabox
//
//  Created by OOng E on 9/22/25.
//

import SwiftUI
import Foundation

struct ManageUserInfoView: View {
    @AppStorage("id") private var id = ""
    @AppStorage("name") private var name = ""
    /* TextField 에서 입력받은 텍스트 임시저장, Button의 action으로 임시저장한 State 변수를 Appstorage로 */
    @State private var tempname: String = ""
    
    
    var body: some View {
        VStack {
            topNavigation
            
            Spacer().frame(height: 53)
            
            text
            
            Spacer().frame(height: 26)
            
            userNameId
            
            Spacer()
        }//.padding(16)
    }
    /* 상단 네비게이션 바 */
    private var topNavigation: some View {
        HStack {
            Button( action: { } ) {
                Image(systemName: "arrow.left")
                    .foregroundStyle(.black)
            }
            Spacer()
            Text("회원정보 관리")
                .font(.PretendardMedium(size: 16))
                .foregroundStyle(.black)
            Spacer()
        }.frame(height: 44)
    }
    
    /* 기본정보 */
    private var text: some View {
        HStack {
            Text("기본정보")
                .font(.PretendardBold(size: 18))
                .foregroundStyle(.black)
            Spacer()
        }
    }
    
    /* User name / User id */
    private var userNameId: some View {
        VStack {
            HStack {
                Text("\(id)")
                    .font(.PretendardMedium(size: 18))
                    .foregroundStyle(.black)
                Spacer()
            }.frame(height: 21)
            
            Divider()
                .padding(.top, -5)
            
            Spacer()
            
            HStack {
                TextField("\(name)", text: $tempname)
                    .font(.PretendardMedium(size: 18))
                    .foregroundStyle(.black)
                
                Spacer()
                
                Button( action: { name = tempname } ) {
                    RoundedRectangle(cornerRadius: 16)
                    /* stroke 사용시 foregroundedStyle 수정자보다 먼저 작성 + import Foundation */
                        .stroke(.gray03, lineWidth: 1)
                        .foregroundStyle(Color.clear)
                        .frame(width: 38, height: 20)
                        .overlay( Text("변경")
                            .font(.PretendardMedium(size: 10))
                            .foregroundStyle(.gray03))
                    }
                }
            
            
            Divider()
                .padding(.top, -5)
            
        }.frame(height: 76.1)
    }
}



#Preview {
    ManageUserInfoView()
}
