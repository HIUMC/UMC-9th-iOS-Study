//
//  MobileOrderView.swift
//  MEGABOX
//
//  Created by 고석현 on 11/15/25.
//

import SwiftUI

// MARK: - 모바일 오더 메인 화면
// 전체 모바일 오더 UI 구성과 네비게이션을 담당하는 화면
struct MobileOrderView: View {
    @State private var viewModel = MobileOrderViewModel()
    @Environment(NavigationRouter.self) private var router
    
    var body: some View {
        VStack(spacing: 0) {
            /// 상단 MEBOX 로고 영역
            HStack {
                Spacer().frame(width: 45)
                Image("meboxLogo")
                    .resizable()
                    .frame(width: 149, height: 30)
                   
                Spacer()
            }
//            .padding(.leading, 10)
           

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 28) {
                  
                    //MARK: - 극장 변경 헤더
                    TheaterSelectHeaderView()
                        .padding(.horizontal, 0.01)
                    
                    /// 바로 주문 / 스토어 교환권 / 선물하기 카드 섹션
                    //스토어 교환권, 선물하기는 재사용

                    HStack(spacing: 12) {
                        //MARK: - 바로 주문 박스
                        DirectOrderCard()
                            .padding(.leading, 20)
                            .onTapGesture {
                                router.push(.menuDetail)
                            }

                        VStack(spacing: 12) {
                            //MARK: - 스토어 교환권 / 선물하기 박스
                            SmallMenuCard(title: "스토어 교환권", imageName: "store")
                            SmallMenuCard(title: "선물하기", imageName: "present")
                        }
                    }

                    
                
                    
                    //어디서든 팝콘 만나기
                    //MARK: - 어디서든 팝콘 만나기 카드
                    DeliveryCard()
                        .padding(.leading, 20)

                       
                    /// 추천 메뉴 섹션
                    MenuHorizontalSectionView(
                        title: "추천 메뉴",
                        menus: viewModel.recommendedMenus,
                        router: router
                    )
                    .padding(.leading, 20)

                    
                    /// 베스트 메뉴 섹션
                    MenuHorizontalSectionView(
                        title: "베스트 메뉴",
                        menus: viewModel.bestMenus,
                        router: router
                    )
                    .padding(.leading, 20)

                }
//                .padding(.leading, 20)
                .padding(.top, 20)
               
              
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - 바로 주문 카드

struct DirectOrderCard: View {
    var body: some View {
        VStack(alignment: .leading) {
            /// 카드 제목
            Text("바로 주문")
                .font(.PretendardBold(size: 24))
                .foregroundColor(.black)

            /// 안내 문구
            Text("이제 줄서지 말고\n모바일로 주문하고 픽업!")
                .font(.PretendardRegular(size: 12))
                .foregroundColor(Color(red: 0.47, green: 0.47, blue: 0.47))
               
                .padding(.top, 6)

            Spacer()

            /// 우측 팝콘 이미지
            HStack {
                Spacer()
                Image("popcorn1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 15)
        .frame(width: 200, height: 308, alignment: .leading)
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 0.5)
                .stroke(Color(red: 0.79, green: 0.77, blue: 0.77), lineWidth: 1)
        )
    }
}

// MARK: - 작은 메뉴 카드 ->재사용
// 스토어 교환권 / 선물하기 카드 UI
struct SmallMenuCard: View {
    let title: String
    let imageName: String

    var body: some View {
        VStack(alignment: .leading) {
            /// 카드 제목
            Text(title)
                .font(.PretendardBold(size: 22))
                .foregroundColor(.black)

            Spacer()

            /// 우측 아이콘 이미지
            HStack {
                Spacer()
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 36, height: 36)
            }
        }
        .padding(.horizontal,20)
        .padding(.vertical, 10)
        .frame(width: 150, height: 150, alignment: .leading)
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 0.5)
                .stroke(Color(red: 0.79, green: 0.77, blue: 0.77), lineWidth: 1)
        )
    }
}

// MARK: - 배달 카드
// 팝콘·스낵 배달 가능 안내 카드 UI
struct DeliveryCard: View {
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 8) {
                /// 배달 안내 텍스트
                Text("어디서든 팝콘 만나기")
                    .font(.PretendardBold(size: 24))
                    .foregroundColor(.black)

                Text("팝콘 콜라 스낵 모든 메뉴 배달 가능!")
                    .font(.PretendardRegular(size: 12))
                    .foregroundColor(Color(red: 0.47, green: 0.47, blue: 0.47))
                    
            }

            Spacer()

            /// 우측 오토바이 이미지
            Image("motor")
                .resizable()
                .scaledToFit()
                .frame(width: 46, height: 46)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 25)
        .frame(width: 360, alignment: .top)
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 0.5)
                .stroke(Color(red: 0.79, green: 0.77, blue: 0.77), lineWidth: 1)
        )
    }
}
    
// MARK: - 극장 선택 헤더
// 현재 선택된 극장 표시 + 극장 변경 버튼 UI
struct TheaterSelectHeaderView: View {
    var body: some View {
        HStack(alignment: .center) {
        
        
            

            Spacer()

           
            HStack {

                // 왼쪽: 위치 아이콘 + 강남
                HStack(spacing: 8) {
                    Image("location")
                        .resizable()
                        .frame(width: 24, height: 24)
                       

                    Text("강남")
                        .font(.PretendardSemiBold(size: 13))
                        .foregroundColor(.white)
                }

                Spacer()

                // 오른쪽: 극장 변경 버튼
                Button {
                    print("극장 변경 눌림")
                } label: {
                    Text("극장 변경")
                        .font(.PretendardSemiBold(size:13))
                        .foregroundStyle(.white)
                        .padding(.vertical,8)
                        .padding(.horizontal, 5)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.white, lineWidth: 1)
                        )
                }
            }

            Spacer()

       
        }
        
        .padding(.vertical,10)
        .background(Color(red: 0.40, green: 0.05, blue: 0.85))
    }
}





// MARK: - 단일 메뉴 카드
// 메뉴 이미지, 제목, 가격을 보여주는 카드 UI
struct MenuCardView: View {
    let item: MenuItemModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            /// 메뉴 이미지
            Image(item.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            Spacer().frame(height:4)
            
            /// 메뉴 제목 / 가격
            Text(item.title)
                .font(.PretendardRegular(size:13))
                .foregroundColor(.black)
            
            Text("\(item.price)원")
                .font(.PretendardSemiBold(size:14))
                .foregroundColor(.black)
        }
    }
}

// MARK: - 메뉴 섹션 (가로 스크롤)
// 추천 메뉴 / 베스트 메뉴 등 가로 스크롤 메뉴 목록 구성
struct MenuHorizontalSectionView: View {
    let title: String
    let menus: [MenuItemModel]
    let router: NavigationRouter
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            /// 섹션 제목
            Text(title)
                .font(.PretendardBold(size:22))
            
            /// 부제 텍스트 (추천 / 베스트별 다르게 표시)
            if title == "추천 메뉴" {
                Text("영화 볼때 뭐먹지 고민될 때 추천메뉴!")
                    .font(.PretendardRegular(size: 12))
                    .foregroundColor(Color(red: 0.47, green: 0.47, blue: 0.47))


                  
            } else if title == "베스트 메뉴" {
                Text("영화 볼때 뭐먹지 고민될때 베스트 메뉴!")
                    .font(.PretendardRegular(size: 12))
                    .foregroundColor(Color(red: 0.47, green: 0.47, blue: 0.47))

                  
            }
            
            /// 가로 스크롤 메뉴 목록
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(menus) { item in
                        Button {
                            router.push(.menuDetail)
                        } label: {
                            MenuCardView(item: item)
                        }
                    }
                }
                .padding(.leading, 0)
            }
        }
    }
}





#Preview("MobileOrder - iPhone 17 Pro") {
    NavigationStack {
        MobileOrderView()
            .environment(NavigationRouter())   // ✅ 프리뷰용 라우터 주입
    }
    .previewDevice("iPhone 17 Pro")
}

#Preview("MobileOrder - iPhone 11") {
    NavigationStack {
        MobileOrderView()
            .environment(NavigationRouter())   // ✅ 프리뷰용 라우터 주입
    }
    .previewDevice("iPhone 11")
}
