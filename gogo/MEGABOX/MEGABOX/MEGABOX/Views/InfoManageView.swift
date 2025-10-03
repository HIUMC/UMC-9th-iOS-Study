//
//  InfoManagerView.swift
//  MEGABOX
//
//  Created by 고석현 on 9/26/25.
//

import SwiftUI

struct InfoManageView: View {
    
    @Environment(\.dismiss) private var dismiss

    @AppStorage("userId") private var savedId: String = "ksh020920"
    @AppStorage("userName") private var savedName: String = "고석현"
    @State private var tempName: String = ""
    
    //MARK: -바디
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
    
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image("back")
                        .resizable()
                        .frame(width: 26, height: 24)
                }
                Spacer()
                
                Text("회원정보 관리")
                    .font(.PretendardMedium(size: 16))
                Spacer()
                Spacer().frame(width: 24)
            }
            .padding(.vertical, 8)
      
            Text("기본정보")
                .font(.PretendardBold(size: 18))
                .padding(.top, 20)
            
       
            HStack {
                Text(savedId)
                Spacer()
            }
            .padding(.vertical, 12)
            .overlay(Rectangle().frame(height: 1).foregroundColor(Color("gray02")), alignment: .bottom)
            
         
            HStack {
                TextField("이름", text: $tempName)
                    .textFieldStyle(PlainTextFieldStyle())
                 
                
                Spacer()
                
                Button("변경") {
                    savedName = tempName
                }
                .font(.PretendardMedium(size: 10))
                .foregroundColor(Color("gray03"))
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color("gray03"), lineWidth: 1)
                        )
            }
            .padding(.vertical, 12)
            .overlay(Rectangle().frame(height: 1).foregroundColor(Color("gray02")), alignment: .bottom)
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .onAppear {
            
            tempName = savedName
        }
    }
}

//프리뷰 (과제용/아이폰 11, 16프로)
#Preview("iPhone 11") {
   InfoManageView()
}

#Preview("iPhone 16 Pro") {
    InfoManageView()
}
