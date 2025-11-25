//
//  MenuDetailView.swift
//  MEGABOX
//
//  Created by 고석현 on 11/15/25.
//

import SwiftUI


/// MARK: - 메뉴 상세 페이지
/// 선택된 메뉴를 보여주고, 상단 네비게이션과 극장 선택, 메뉴 리스트를 구성
struct MenuDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    
    var viewModel: MobileOrderViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                
                /// 상단 뒤로가기 / 장바구니 / 제목 영역
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.black)
                            .padding(8)
                            .background(.ultraThinMaterial)   // ← Liquid Glass 효과
                            .clipShape(Circle())
                    }

                    Spacer()

                    Text("바로주문")
                        .font(.PretendardSemiBold(size: 20))

                    Spacer()

                    Button(action: {}) {
                        Image("bag")
                            .font(.system(size: 18))
                            .foregroundColor(.black)
                            .padding(8)
                            .background(.ultraThinMaterial) // ← Liquid Glass 효과
                            .clipShape(Circle())
                    }
                }
                .padding(.top, 10)
                .padding(.horizontal, 20)
                
                /// 극장 선택 헤더 (상세 페이지용 밝은 스타일)
                TheaterSelectHeaderDetailsView()
                
                /// 메뉴 카드 그리드 (2열 구성)
                let columns = [
                    GridItem(.flexible(), spacing: 20),
                    GridItem(.flexible(), spacing: 10)
                ]
                
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.menus) { item in
                      
                        MenuCardsView(item: item)
                    }
                }
                .padding(.top, 10)
                .padding(.horizontal, 20)
            }
//            .padding(.horizontal, 20)
        }
        .navigationBarBackButtonHidden()
    }
}

/// MARK: - 헤더 색상 변경 Modifier
/// 상세 페이지용 밝은 헤더 배경 스타일 구성
struct TheaterHeaderStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.white) // 상세페이지용 밝은 그레이
    }
}

extension View {
    func theaterHeaderLight() -> some View {
        modifier(TheaterHeaderStyle())
    }
}

/// MARK: - 극장 선택 헤더 Wrapper
/// TheaterSelectHeadersView 에 Modifier 적용
struct TheaterSelectHeaderDetailsView: View {
    var body: some View {
        TheaterSelectHeadersView()
            .theaterHeaderLight()
    }
}

/// MARK: - 극장 선택 헤더
/// 현재 극장 위치 표시 + 극장 변경 버튼 UI
struct TheaterSelectHeadersView: View {
    var body: some View {
        HStack(alignment: .center) {

        
            

            Spacer()

           
            HStack {

                // 왼쪽: 위치 아이콘 + 강남
                HStack(spacing: 8) {
                    /// 위치 아이콘
                    Image("location1")
                        .resizable()
                        .frame(width: 24, height: 24)
                      
                       

                    Text("강남")
                        .font(.PretendardSemiBold(size: 13))
                        .foregroundColor(.black)
                }

                Spacer()

                // 오른쪽: 극장 변경 버튼
                Button {
                    print("극장 변경 눌림")
                } label: {
                    Text("극장 변경")
                        .font(.PretendardSemiBold(size:13))
                        .foregroundColor(Color(red: 0.4, green: 0.05, blue: 0.85))
                        .padding(.vertical,8)
                        .padding(.horizontal, 5)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
            }

            Spacer()

       
        }
        
        .padding(.vertical,10)
     
    }
}

/// MARK: - 메뉴 카드
/// 이미지 + 이름 + 가격 + 배지/품절 표시를 포함하는 단일 카드
struct MenuCardsView: View {
    let item: MenuItemModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            
            /// 메뉴 이미지 + 배지/품절 Modifier 적용
            Image(item.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 170, height: 170)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            //뷰 modifiers 적용
                .bestBadge(item.isBest)
                .recommendBadge(item.isRecommended)
                .soldOut(item.isSoldOut)
            
            /// 메뉴 제목
            Text(item.title)
                .font(.PretendardRegular(size: 13))
                .foregroundColor(.black)
                .lineLimit(1)
            
            /// 메뉴 가격
            Text("\(item.price)원")
                .font(.PretendardBold(size: 13))
                .foregroundColor(.black)
        }
        .frame(width: 191)
    }
}

/// MARK: - BEST 배지 Modifier
/// 메뉴가 BEST 상품일 때 좌측 상단에 배지를 표시
struct BestBadgeModifier: ViewModifier {
    let isBest: Bool
    
    func body(content: Content) -> some View {
        ZStack(alignment: .topLeading) {
            content
            
            if isBest {
                Image("best")
                    .resizable()
                    .frame(width: 44, height: 20)
//                    .padding(8)
            }
        }
    }
}

/// MARK: - 추천 배지 Modifier
/// 추천 상품 표시용 배지
struct RecommendBadgeModifier: ViewModifier {
    let isRecommended: Bool
    
    func body(content: Content) -> some View {
        ZStack(alignment: .topLeading) {
            content
            
            if isRecommended {
                Image("recommend") // 필요 시 에셋 구성
                    .resizable()
                    .frame(width: 44, height: 20)
//                    .padding(8)
            }
        }
    }
}

/// MARK: - 품절 오버레이 Modifier
/// 품절 상태일 때 어둡게 처리 후 ‘품절’ 텍스트 표시
struct SoldOutModifier: ViewModifier {
    let isSoldOut: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isSoldOut {
                Rectangle()
                    .fill(Color.black.opacity(0.8))
                    .frame(width: 170, height: 170)
                    .shadow(color: .black.opacity(0.25), radius: 25, x: 0, y: 4)
                
                Text("품절")
                    .font(.PretendardBold(size: 16))
                    .foregroundColor(.white)
            }
        }
    }
}

/// MARK: - 메뉴 배지 및 품절 Modifier Extension
extension View {
    func bestBadge(_ value: Bool) -> some View {
        modifier(BestBadgeModifier(isBest: value))
    }
    func recommendBadge(_ value: Bool) -> some View {
        modifier(RecommendBadgeModifier(isRecommended: value))
    }
    func soldOut(_ value: Bool) -> some View {
        modifier(SoldOutModifier(isSoldOut: value))
    }
}

#Preview {
    MenuDetailView(viewModel: MobileOrderViewModel())
}
