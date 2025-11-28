//
//  MobileOrderView.swift
//  MEGABOX
//
//  Created by 박정환 on 11/19/25.
//

import SwiftUI

struct MobileOrderView: View {

    @Environment(MobileOrderViewModel.self) var viewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                Image(.meboxTitle)
                    .padding(16)

                // 극장 변경 바
                LocationBarView()
                    .purpleStyle()

                VStack(alignment: .leading, spacing: 24) {
                    
                    // 바로 주문 / 스토어 교환권 / 선물하기 / 팝콘 섹션
                    QuickActionView()
                        .padding(.top, 24)
                    
                    // 추천 메뉴
                    MenuSectionView(
                        title: "추천 메뉴",
                        subtitle: "영화 볼 때 뭐먹지 고민될 땐 추천 메뉴!",
                        items: viewModel.recommendedMenu
                    )
                    .padding(.top, 24)
                    
                    // 베스트 메뉴
                    MenuSectionView(
                        title: "베스트 메뉴",
                        subtitle: "영화 볼 때 뭐먹지 고민될 땐 베스트 메뉴!",
                        items: viewModel.bestMenu
                    )
                    .padding(.top, 24)
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

struct QuickActionView: View {
    @Environment(NavigationRouter.self) private var router
    var body: some View {
        VStack(alignment:. leading, spacing: 20) {
            HStack(spacing: 15) {
                Button {
                    router.push(.mobileOrderDetail)
                } label: {
                    VStack(alignment: .leading) {
                        Text("바로 주문")
                            .font(.bold24)

                        Text("이제 줄서지 말고\n모바일로 주문하고 픽업!")
                            .font(.regular12)
                            .foregroundColor(.gray)
                            .padding(.top,5)

                        Spacer()

                        Image(systemName: "popcorn")
                            .font(.system(size: 32))
                    }
                    .padding(15)
                    .frame(height: 308)
                    .frame(maxWidth: 232, alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray02, lineWidth: 1)
                    )
                }
                .buttonStyle(.plain)

                VStack(spacing: 10) {
                    Button {
                        // 스토어 교환권
                    } label: {
                        VStack(alignment: .leading) {
                            Text("스토어 교환권")
                                .font(.bold22)

                            Spacer()

                            Image(systemName: "ticket")
                                .font(.system(size: 28))
                        }
                        .padding(15)
                        .frame(height: 150)
                        .frame(maxWidth: 232, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray02, lineWidth: 1)
                        )
                    }
                    .buttonStyle(.plain)

                    Button {
                        // 선물하기
                    } label: {
                        VStack(alignment: .leading) {
                            Text("선물하기")
                                .font(.bold22)

                            Spacer()

                            Image(systemName: "gift")
                                .font(.system(size: 28))
                        }
                        .padding(15)
                        .frame(height: 150)
                        .frame(maxWidth: 232, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray02, lineWidth: 1)
                        )
                    }
                    .buttonStyle(.plain)
                }
            }

            Button {
                // 어디서든 팝콘 만나기
            } label: {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("어디서든 팝콘 만나기")
                            .font(.bold22)

                        Text("팝콘 콜라 스낵 모든 메뉴 배달 가능!")
                            .font(.regular12)
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    Image(systemName: "scooter")
                        .font(.system(size: 32))
                }
                .padding()
                .frame(height: 104)
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray02, lineWidth: 1)
                )
            }
            .buttonStyle(.plain)
        }
    }
}

struct MenuSectionView: View {
    let title: String
    let subtitle: String
    let items: [MenuItemModel]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text(title)
                .font(.bold22)
            
            Text(subtitle)
                .font(.regular12)
                .foregroundColor(.gray)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(items) { item in
                        MenuItemCard(item: item)
                    }
                }
            }
        }
    }
}

#Preview {
    MobileOrderView()
        .environment(NavigationRouter())
        .environment(MovieViewModel())
        .environment(MobileOrderViewModel())
}
