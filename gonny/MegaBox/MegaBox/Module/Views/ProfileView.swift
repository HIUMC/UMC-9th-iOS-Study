//
//  ProfileView.swift
//  MegaBox
//
//  Created by 박병선 on 10/1/25.
//
import SwiftUI

struct ProfileView: View{
    
    @Environment(NavigationRouter.self) private var router
    @State private var showImagePicker = false
    @State private var selectedImages: [UIImage] = []

    var body: some View{
        VStack(alignment: .leading, spacing: 15){
            profileHeaderView()
            clubMembershipView()
            couponInfoView()
            reservationView()
        }
    }
}

//MARK: -하위뷰
///헤더뷰
struct profileHeaderView: View {
    @Environment(NavigationRouter.self) private var router
    @EnvironmentObject var auth: LoginViewModel // loginVM의 데이터를 받아온 auth라는 변수
    @State private var showImagePicker = false
    @State private var selectedImages: [UIImage] = []
    
    
     //@StateObject var auth: LoginViewModel
    @AppStorage("userName") private var savedName: String =  "이*원"
    @AppStorage("userPoint") private var savedPoint: Int = 500
    @AppStorage("profileImageData") private var profileImageData: Data?   // 프사 저장용
    
    var body: some View {
        
        HStack(spacing: 16) {
            // 프로필 이미지
            profileImageView
                .onLongPressGesture  {
                    showImagePicker = true
                    }
                     .sheet(isPresented: $showImagePicker) {
                        ImagePicker(
                          images: $selectedImages,
                          selectedLimit: 1      // 프로필 → 한 장만
                        )
                    }
                    .onChange(of: selectedImages) { oldValue, newValue in
                    // 새 사진이 1장 들어왔을 때 저장
                        if let image = newValue.first,
                           let data = image.jpegData(compressionQuality: 0.8) {
                            profileImageData = data
                        }
                    }
            // 왼쪽: 프로필 정보
            VStack(alignment: .leading, spacing: 4) {

                // 이름 + 배지
                HStack {
                     Text("\(savedName)님")
                        .font(.pretendardBold(24))
                        .padding(.leading)
                     
                    
                    Text("WELCOME")
                        .font(.pretendardMedium(14))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(Color("tag"))
                        .foregroundStyle(Color.white00)
                        .cornerRadius(6)
                }
                
                HStack{
                    // 포인트
                    Text("멤버십 포인트")
                        .font(.pretendardSemiBold(14))
                        .foregroundStyle(Color.gray04)
                        .padding(.leading)
                    
                    Text("\(savedPoint)P")
                        .font(.pretendardMedium(14))
                        .foregroundStyle(Color.black00)
                }
                

            }
            
            Spacer()
            
            // 오른쪽: 회원정보 버튼
            Button(action: {
                router.push(MemberInfoView()) 
            }) {
                Text("회원정보")
                    .font(.pretendardSemiBold(14))
                    .foregroundStyle(Color.white00)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.gray07)
                    .cornerRadius(16)
            }
            .padding(.trailing)
            .padding(.top, -20)
        }
        .padding(.top,10)
        .onAppear {
                    // 저장된 프로필 이미지 불러오기
                    if let data = profileImageData,
                       let img = UIImage(data: data) {
                        selectedImages = [img]    // 편하게 넣기
                    }
                }
    }
    
    @ViewBuilder
       private var profileImageView: some View {
           Group {
               if let first = selectedImages.first {
                   Image(uiImage: first)
                       .resizable()
                       .scaledToFill()
                       .clipShape(Circle())

               } else if let data = profileImageData,
                         let img = UIImage(data: data) {
                   Image(uiImage: img)
                       .resizable()
                       .scaledToFill()
                       .clipShape(Circle())

               } else {
                   Image("default_profile")   // 기본값
                       .resizable()
                       .scaledToFit()
                       .frame(width:55, height:55)
                       .padding(.leading, 20)
               }
           }
           .frame(width: 52, height: 52)
       }
}

struct clubMembershipView: View{
    var body: some View{
        Button(action: {
            print("클럽 멤버십 버튼 클릭")
        }) {
            HStack {
                Text("클럽 멤버십")
                    .font(.pretendardSemiBold(16))
                    .foregroundStyle(.white00)
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.white00)
                    .font(.pretendardSemiBold(16))

                Spacer()
            }
            .padding() //텍스트 위아래 공간확보
        }
        .background(
            LinearGradient(
                colors: [Color(hex: "AB8BFF"), Color(hex: "8EAEF3"), Color(hex: "5DCCEC")],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .cornerRadius(8) // 둥근 모서리
        .padding(.horizontal)
    }
}

struct couponInfoView: View {
    var body: some View {
        
        HStack(spacing: 10) {
            // 쿠폰
            VStack(spacing: 8) {
                Text("쿠폰")
                    .font(.pretendardSemiBold(16))
                    .foregroundStyle(.gray02)
                Text("2")
                    .font(.pretendardSemiBold(18))
                    .foregroundStyle(.black00)

            }
            .frame(maxWidth: .infinity)
            .padding(.top, 5)
            
            
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 1, height: 40)
            
            // 스토어 교환권
            VStack(spacing: 8) {
                Text("스토어 교환권")
                    .font(.pretendardSemiBold(16))
                    .foregroundStyle(.gray02)
                Text("0")
                    .font(.pretendardSemiBold(18))
                    .foregroundStyle(.black00)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 5)
        
            
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 1, height: 40)
                
            
            // 모바일 티켓
            VStack(spacing: 8) {
                Text("모바일 티켓")
                    .font(.pretendardSemiBold(16))
                    .foregroundStyle(.gray02)
                Text("0")
                    .font(.pretendardSemiBold(18))
                    .foregroundStyle(.black00)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 5)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
        .padding(.horizontal)
    }
}

 struct reservationView: View{
    var body: some View{
        HStack{
            Button(action: {
                
            }) {
                VStack(spacing:10) {
                    Image("movie_reservation")
                        .resizable()
                        .frame(width: 36, height: 36)
                    
                    Text("영화별예매")
                        .font(.pretendardMedium(16))
                        .foregroundStyle(.black00)
                }
            }
            
            Spacer()
            
            Button(action: {
                
            }) {
                VStack(spacing:10) {
                    Image("theater_reservation")
                        .resizable()
                        .frame(width: 36, height: 36)
                    
                    Text("극장별예매")
                        .font(.pretendardMedium(16))
                        .foregroundStyle(.black00)
                }
            }
            
            Spacer()
            
            Button(action: {
                
            }) {
                VStack(spacing:10) {
                    Image("special_theater")
                        .resizable()
                        .frame(width: 36, height: 36)
                    
                    Text("특별과예매")
                        .font(.pretendardMedium(16))
                        .foregroundStyle(.black00)
                }
            }
            
            Spacer()
            
            Button(action: {
                
            }) {
                VStack(spacing:10) {
                    Image("mobile_order")
                        .resizable()
                        .frame(width: 36, height: 36)
                    
                    Text("영화별예매")
                        .font(.pretendardMedium(16))
                        .foregroundStyle(.black00)
                }
            }
        }
        .padding(.leading)
        .padding(.trailing)
        .padding(.top)
        
    }
}


 

// MARK: - ProfileView 전체 프리뷰
#Preview {
    ProfileView()
        .environment(NavigationRouter())
        .environmentObject(LoginViewModel())
}

