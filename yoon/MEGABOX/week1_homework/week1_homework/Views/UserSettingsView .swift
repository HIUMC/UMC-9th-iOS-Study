//
//  UserSettingsView .swift
//  week1_homework
//
//  Created by 정승윤 on 9/25/25.
//

import Foundation
import SwiftUI

struct UserSettingsView: View {
    @AppStorage("idinfo") private var idinfo : String = ""
    @AppStorage("pwdinfo") private var pwdinfo : String = ""
    @AppStorage("nameinfo") private var nameinfo : String = ""
    @State private var newname: String = ""
    
    var body: some View {
        VStack{
            HStack{
                NavigationBar
            }
            
            Spacer().frame(height:53)
            
            Text("기본정보")
                .font(.PretendardBold18)
                .frame(width: 408,height: 24,alignment: .leading)
            
            Spacer().frame(height:26)
            
            UserInfo
            
            Spacer()
            
        }.padding(.horizontal, 16)
}
    
    private var NavigationBar: some View {
        VStack{
            HStack{
                Button(action: {
                }){Text(Image(systemName: "arrow.left")).foregroundStyle(.black)}
                    
                Spacer()
                
                Text("회원정보 관리")
                        .font(.Pretendardmedium16)
                        .padding(.trailing,162)
                }.frame(width: 408)
            }.padding(.horizontal,16)
        }
    
    private var UserInfo: some View {
        VStack{
            TextField("아이디", text: $idinfo)
                .disabled(true) // 텍스트로 줘도 댐
                .padding(.bottom, 3) // 패딩 주는게 맞어요? 피그마랑 너무 차이나는데
            
            Divider()
            
            Spacer().frame(height:24)
            
            HStack{
                TextField("이름", text: $newname)
                
                Button(action:{
                    self.nameinfo = self.newname
                }){Text("변경").font(.Pretendardmedium10).foregroundStyle(.gray03)
                        .frame(width:38,height:20)
                    .background(RoundedRectangle(cornerRadius: 16).stroke(Color.gray03,lineWidth: 1))}
            }.padding(.bottom, 3)
            
            Divider()
        }
    }
}

struct UserSetting_Preview: PreviewProvider {
    static var previews: some View {
        devicePreviews {
            UserSettingsView()
        }
    }
}
