//
//  LoginView.swift
//  week1_homework
//
//  Created by 정승윤 on 9/15/25.
//

import SwiftUI
import Foundation

struct LoginView: View {
    @Bindable var loginInput: LoginViewModel
    @AppStorage("idinfo") private var idinfo : String = ""
    @AppStorage("pwdinfo") private var pwdinfo : String = ""
    @AppStorage("nameinfo") private var nameinfo : String = ""
    @State private var newname: String = ""
    
    init(loginInput: LoginViewModel) {
        self.loginInput = loginInput
    }
    // 초깃값을 LoginViewModel의 초깃값으로 설정
    var body: some View {
        VStack{
            TopBanner
            
            Spacer().frame(height: 157)
            
            LoginInput
            
            Spacer().frame(height: 35)
            
            SocialLogin
            
            Spacer().frame(height: 39)
            
            UMCImage
            
        }.padding(.horizontal, 16)
        
        VStack{
            Spacer().frame(height:59)
            
            ProfileHeader
            
            Spacer().frame(height:15)
            
            ClubMembership
            
            Spacer().frame(height:33)
            
            StatusInfo
            
            Spacer().frame(height:33)
            
            TicketResv
            
            Spacer()
            
        }.padding(.horizontal, 16)
        
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
    
    
    private var TopBanner:some View {
        HStack{
            Text("로그인").font(.PretendardsemiBold24)
        }
    }
    
    private var LoginInput:some View {
        VStack{
            TextField("아이디", text: $loginInput.loginModel.id)
                .padding(.bottom,4)
                .foregroundStyle(.gray03)
            
            Divider().foregroundStyle(.gray02).frame(height:1)
            
            Spacer().frame(height: 40)
            
            SecureField("비밀번호",text: $loginInput.loginModel.pwd)
                .padding(.bottom,4)
                .foregroundStyle(.gray03)
            
            Divider().foregroundStyle(.gray02).frame(height:1)
            
            Spacer().frame(height:75)
            
            Button(action: {
                self.idinfo = self.loginInput.loginModel.id
                self.pwdinfo = self.loginInput.loginModel.pwd
            }
            ) {
                Text("로그인")
                    .frame(maxWidth:.infinity)
                    .frame(height: 54)
                    .font(.PretendardBold18)
                    .background(.purple03)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
            }
            Spacer().frame(height:17)
            
            Text("회원가입").font(.Pretendardmedium13)
                .foregroundStyle(.gray04)
        }
    }
    
    private var SocialLogin:some View {
        HStack{
            Spacer().frame(width:71)
            Image(.kakaoLogin)
                .resizable()
                .frame(width:40,height:40)
            Spacer()
            Image(.appleLogin)
                .resizable()
                .frame(width:40,height:40)
            Spacer()
            Image(.naverLogin)
                .resizable()
                .frame(width:40,height:40)
            Spacer().frame(width:71)
        }
        
    }
    
    private var UMCImage:some View {
        Image(.UMC)
            .resizable()
            .scaledToFit()
    }
    
    private var ProfileHeader:some View {
        VStack(alignment: .leading){
            HStack {
                Text(nameinfo)
                    .font(.PretendardBold24)
                
                Text("WELCOME")
                    .padding(.horizontal, 8)
                    .padding(.vertical,4)
                    .font(.Pretendardmedium14)
                    .foregroundStyle(.white)
                    .background(.tag)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                
                Spacer()
                
                Button(action: {
                }){Text("회원정보")
                        .frame(width: 72)
                        .padding(.vertical, 4)
                    .font(.PretendardsemiBold14)}
                .foregroundStyle(.white)
                .background(.gray07)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                
            }
            // width, height 고정이면 frame으로 크기조정. padding X
            HStack(spacing: 9){
                Text("멤버십 포인트")
                    .font(.PretendardsemiBold14)
                    .foregroundStyle(.gray04)
                
                Text("500P")
                    .font(.Pretendardmedium14)
                    .foregroundStyle(.black)
            }
        }
    }
    
    private var ClubMembership:some View {
        Button(action:{}) {
            HStack(spacing:3 ){
                Text("클럽 멤버십")
                    .font(.PretendardsemiBold16)
                    .foregroundStyle(.white)
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.white)
                
                
            }.frame(maxWidth: .infinity)
                .padding(.vertical,12)
                .padding(.leading, 8)
                .padding(.trailing, 308)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color("AB8BFF"), Color("8EAEF3"), Color("5DCCEC")]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ) // ColorAsset 등록 안하고 가능?
                )
        }.clipShape(RoundedRectangle(cornerRadius: 8))
        
    }
    private var StatusInfo:some View {
        
        HStack(spacing:43){
            
            VStack(spacing:9){
                Text("쿠폰")
                    .font(.PretendardsemiBold16)
                    .foregroundStyle(.gray02)
                Text("2")
                    .font(.PretendardsemiBold18)
                    .foregroundStyle(.black)
            }.frame(width: 28,height: 52)
            
            Divider().frame(height:31)
            
            VStack(spacing:9){
                Text("스토어 교환권")
                    .font(.PretendardsemiBold16)
                    .foregroundStyle(.gray02)
                Text("0")
                    .font(.PretendardsemiBold18)
                    .foregroundStyle(.black)
            }.frame(width: 87,height: 52)
            
            Divider().frame(height:31)
            
            VStack(spacing:9){
                Text("모바일 티켓")
                    .font(.PretendardsemiBold16)
                    .foregroundStyle(.gray02)
                Text("0")
                    .font(.PretendardsemiBold18)
                    .foregroundStyle(.black)
            }.frame(width: 73,height: 52)
            
        }.frame(maxWidth:.infinity)
            .padding(.horizontal,24)
            .padding(.vertical,12)
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray02,lineWidth: 1))
         
    }
    
    private var TicketResv: some View {
        HStack{
            VStack(spacing:12){
                Image(.film)
                    .resizable()
                    .frame(width:36,height:36)
                Text("영화별예매")
                    .font(.Pretendardmedium16)
                
            }
            Spacer()
            VStack(spacing:12){
                Image(.location)
                    .resizable()
                    .frame(width:36,height:36)
                Text("극장별예매")
                    .font(.Pretendardmedium16)
                
            }
            Spacer()
            VStack(spacing:12){
                Image(.chair)
                    .resizable()
                    .frame(width:36,height:36)
                Text("특별관예매")
                    .font(.Pretendardmedium16)
                
            }
            Spacer()
            VStack(spacing:12){
                Image(.popcorn)
                    .resizable()
                    .frame(width:36,height:36)
                Text("모바일오더")
                    .font(.Pretendardmedium16)
                
            }
        }
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
                .disabled(true)
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
struct Login_Preview: PreviewProvider {
    static var previews: some View {
        devicePreviews {
            LoginView(loginInput: LoginViewModel())
        }
    }
}
