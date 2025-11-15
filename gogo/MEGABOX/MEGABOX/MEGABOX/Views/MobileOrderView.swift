//
//  MobileOrderView.swift
//  MEGABOX
//
//  Created by 고석현 on 11/15/25.
//

import SwiftUI

struct MobileOrderView: View {
    @State private var viewModel = MobileOrderViewModel()
    @Environment(NavigationRouter.self) private var router
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 28) {
                
                // MARK: - 극장 변경 헤더
                TheaterSelectHeaderView()
                
                // MARK: - 네모 메뉴 4개 (재사용 가능)
                SquareMenuGridView(router: router)
                
                // MARK: - 추천 메뉴
                MenuHorizontalSectionView(
                    title: "추천 메뉴",
                    menus: viewModel.recommendedMenus,
                    router: router
                )
                
                // MARK: - 베스트 메뉴
                MenuHorizontalSectionView(
                    title: "베스트 메뉴",
                    menus: viewModel.bestMenus,
                    router: router
                )
            }
            .padding(.horizontal, 16)
            .padding(.top, 20)
        }
        .navigationTitle("바로 주문")
        .navigationBarTitleDisplayMode(.inline)
    }
}


// MARK: - 극장 변경 헤더
struct TheaterSelectHeaderView: View {
    var body: some View {
        HStack {
            HStack(spacing: 6) {
                Image(systemName: "mappin.circle.fill")
                Text("강남")
            }
            .font(.system(size: 16, weight: .semibold))
            
            Spacer()
            
            Button {
                // TODO: - 극장 선택 네비게이션
            } label: {
                Text("극장 변경")
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                    .padding(.vertical, 6)
                    .padding(.horizontal, 14)
                    .background(Color.purple)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
        }
    }
}


// MARK: - 네모 메뉴 아이템
struct SquareMenuItemView: View {
    let title: String
    let subtitle: String?
    let systemImage: String
    let height: CGFloat
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Image(systemName: systemImage)
                    .font(.system(size: 30))
                    .foregroundColor(.black)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 2)
        }
    }
}

// MARK: - 네모 메뉴 전체 그리드
struct SquareMenuGridView: View {
    let router: NavigationRouter
    
    var body: some View {
        VStack(spacing: 16) {
            
            // MARK: - 첫 번째 줄
            HStack(spacing: 12) {
                
                // 크게 하나 (바로 주문)
                SquareMenuItemView(
                    title: "바로 주문",
                    subtitle: "이제 빠르게 주문해요!",
                    systemImage: "bag",
                    height: 140
                ) {
                    // TODO: 바로 주문 네비게이션
                }
                
                VStack(spacing: 12) {
                    SquareMenuItemView(
                        title: "스토어 교환권",
                        subtitle: nil,
                        systemImage: "ticket",
                        height: 65
                    ) {
                        print("스토어 교환권 클릭")
                    }
                    
                    SquareMenuItemView(
                        title: "선물하기",
                        subtitle: nil,
                        systemImage: "gift",
                        height: 65
                    ) {
                        print("선물하기 클릭")
                    }
                }
            }
            
            // MARK: - 두 번째 줄
            SquareMenuItemView(
                title: "어디서든 팝콘 만나기",
                subtitle: "편한 곳에서 스낵 주문 가능!",
                systemImage: "car",
                height: 90
            ) {
                print("팝콘 만나기 클릭")
            }
        }
    }
}


// MARK: - 메뉴 카드
struct MenuCardView: View {
    let item: MenuItemModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(item.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Text(item.title)
                .font(.system(size: 14, weight: .semibold))
            
            Text("\(item.price)원")
                .font(.system(size: 12))
                .foregroundColor(.gray)
        }
    }
}

// MARK: - 메뉴 섹션 (가로 스크롤)
struct MenuHorizontalSectionView: View {
    let title: String
    let menus: [MenuItemModel]
    let router: NavigationRouter
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Text(title)
                .font(.system(size: 18, weight: .bold))
            
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
            }
        }
    }
}


