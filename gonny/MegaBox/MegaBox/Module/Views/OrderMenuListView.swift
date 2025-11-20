//
//  Untitled.swift
//  MegaBox
//
//  Created by 박병선 on 11/20/25.
//
import SwiftUI

struct OrderMenuListView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var theaterName: String = "강남"
    
    private let items = MenuItemSampleData.all
    
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // 상단 네비
            topNavigationBar
            
            // 극장 변경 바
            TheaterChangeBarView(theaterName: theaterName) {
                // TODO: 극장 변경 화면 이동
            }
            
            // 메뉴 리스트
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(items) { item in
                        OrderMenuItemCardView(item: item)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 24)
            }
            .background(Color(hex: "F3F3F5"))
        }
        .background(Color(hex: "F3F3F5"))
        .ignoresSafeArea(edges: .bottom)
    }
    
    private var topNavigationBar: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.black00)
            }
            
            Spacer()
            
            Text("바로주문")
                .font(.pretendardSemiBold(17))
                .foregroundStyle(.black00)
            
            Spacer()
            
            Button {
                // TODO: 장바구니 이동
            } label: {
                Image(systemName: "cart")
                    .font(.system(size: 18))
                    .foregroundStyle(.black00)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(Color.white)
    }
}

