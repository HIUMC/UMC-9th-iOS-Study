//
//  MenuDetailView.swift
//  MEGABOX
//
//  Created by 정승윤 on 11/19/25.
//

import Foundation
import SwiftUI

struct MenuDetailView: View {
    @State private var viewModel = MobileOrderViewModel()
    @State private var isDetailStyle: Bool = true
    @EnvironmentObject var router: NavigationRouter
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            NavigationBar.padding(.horizontal,16)
            TheaterTopBar(theaterName: "강남", onTapChange: {isDetailStyle.toggle()})
                .theaterTopBarStyle(isDetailStyle: isDetailStyle)
            ScrollView {
            MenuList(menus: viewModel.menus)
                .padding(.horizontal, 20) // 좌우 패딩 추가
            }
        }
    }
    
    private var NavigationBar: some View {
            HStack{
                Button(action: {dismiss()
                }){Text(Image(systemName: "arrow.left")).foregroundStyle(.black)}
                    
                Spacer()
                
                Text("바로주문")
                        .font(.Pretendardmedium18)
                Spacer()
                
                Text(Image(systemName: "cart"))
            }.frame(maxWidth: .infinity)
        }
        
    
    struct MenuList: View {
        let menus: [MenuItemModel]
        
        private let gridLayout = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        var body: some View {
                    LazyVGrid(columns: gridLayout, spacing: 30) {
                        ForEach(menus) { menu in
                            MenuCard(menu: menu)
                        }
                    }
                    .padding(.top, 25) // TopBar와의 간격
                }
    }
}

#Preview {
    let router = NavigationRouter()
    MenuDetailView()
        .environmentObject(router) // EnvironmentObject로 주입
}
