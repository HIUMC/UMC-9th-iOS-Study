//
//  MobileOrderView.swift
//  MegaBox
//
//  Created by 박병선 on 9/30/25.

import SwiftUI

struct MobileOrderView: View {
    
    // 샘플 데이터
    private let recommendedMenus = MenuItemSampleData.recommended
    private let bestMenus = MenuItemSampleData.best
    
    @State private var theaterName: String = "강남"
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    
                    // MARK: - 상단 극장 선택 바
                    TopTheaterBarView(
                       theaterName: theaterName,
                       onChangeTheater:
                        {
                          // TODO: 극장 변경 화면 네비게이션
                        }
                    )
                    
                    // MARK: - 바로 주문 / 스토어 교환권 / 선물하기 / 어디서든 팝콘
                    quickActionGrid
                    
                    // MARK: - 추천 메뉴 섹션
                    menuSection(
                        title: "추천 메뉴",
                        subtitle: "영화 볼 때 뭐 먹지 고민되면 추천 메뉴!",
                        items: recommendedMenus
                    )
                    
                    // MARK: - 베스트 메뉴 섹션
                    menuSection(
                        title: "베스트 메뉴",
                        subtitle: "영화 볼 때 뭐 먹지 고민되면 베스트 메뉴!",
                        items: bestMenus
                    )
                }
                .padding(.vertical, 16)
            }
            .background(Color.white00)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack{
                        Image("megabox_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 30)
                        Spacer()
                    }
                        
                }
            }
        }
    }
}

// MARK: - Subviews
private extension MobileOrderView {
    
    var quickActionGrid: some View {
        VStack(spacing: 30) {
            
            // 2열 그리드
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 12),
                GridItem(.flexible(), spacing: 12)
            ], spacing: 12) {
                
                // 1) 큰 바로 주문 카드 (세로 2칸 차지)
                quickActionCard(
                    title: "바로 주문",
                    subtitle: "이제 줄서지 말고\n모바일로 주문하고 픽업",
                    systemImage: "popcorn"
                )
                .frame(height: 180)   // -> 2칸
                
                VStack(spacing: 12) {
                    // 2) 스토어 교환권
                    quickActionCard(
                        title: "스토어 교환권",
                        subtitle: "",
                        systemImage: "ticket"
                    )
                    .frame(height: 84)   // -> 1칸
                    
                    // 3) 선물하기
                    quickActionCard(
                        title: "선물하기",
                        subtitle: "",
                        systemImage: "gift"
                    )
                    .frame(height: 84)
                }
            }
            
            // 4) 맨 아래 전폭 카드
            quickActionCard(
                title: "어디서든 팝콘 만나기",
                subtitle: "팝콘 콜라 스낵 모든 메뉴 배달 가능!",
                systemImage: "scooter"
            )
            .frame(height: 84)
        }
        .padding(.horizontal, 16)
    }

    
    func quickActionCard(
        title: String,
        subtitle: String,
        systemImage: String,
        isPrimary: Bool = false
    ) -> some View {
        /*
         if title == "바로 주문" {
                 OrderMenuListView()
             } else {
                 Text("\(title) 상세 페이지")
             }
         } label: {
             quickActionCardBody
         }
         */
        NavigationLink {
            if title == "바로 주문" {
                    OrderMenuListView()
                } else {
                    Text("\(title) 상세 페이지")
                }
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.pretendardBold(24))
                    .foregroundStyle(.black00)
                
                Text(subtitle)
                    .font(.pretendardRegular(14))
                    .foregroundStyle(Color(hex: "797979"))
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
                
                HStack{
                    Spacer()
                    Image(systemName: systemImage)
                        .font(.system(size: 24))
                        .foregroundStyle(.black00)
                    
                }
            }
            .padding(14)
            .frame(maxWidth: .infinity, minHeight: 120, alignment: .topLeading)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(.systemGray4), lineWidth: 1)
            )
        }
    }
    
    func menuSection(
        title: String,
        subtitle: String,
        items: [MenuItemModel]
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            // 섹션 헤더
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.pretendardBold(22))
                    .foregroundStyle(.black00)
                
                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundStyle(Color(hex: "797979"))
            }
            .padding(.horizontal, 16)
            
            // 가로 스크롤 카드 리스트
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(items) { item in
                        NavigationLink {
                            MenuDetailView(item: item)
                        } label: {
                            MenuItemCardView(item: item)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

// MARK: - 메뉴 상세 페이지 (임시)
struct MenuDetailView: View {
    let item: MenuItemModel
    
    var body: some View {
        VStack(spacing: 16) {
            Image(item.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            
            Text(item.name)
                .font(.title2.bold())
            
            Text("\(item.price.formatted())원")
                .font(.title3.weight(.semibold))
            
            Spacer()
        }
        .padding()
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MobileOrderView()
}
