//
//  MobileOrderDetailView.swift
//  MEGABOX
//
//  Created by 박정환 on 11/19/25.
//

import SwiftUI

struct MobileOrderDetailView: View {
    @StateObject private var viewModel = MobileOrderDetailViewModel()

    var body: some View {
        VStack(spacing: 0) {

            NavigationBar()

            ScrollView {
                LocationBarView()
                    .whiteStyle()
                
                Divider()
                    .background(Color.gray01)
                    .padding(.bottom, 8)

                
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 30) {

                    ForEach(viewModel.items) { item in
                        MenuItemCard(item: item)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
            }
        }
        .navigationBarHidden(true)
    }
    
    private struct NavigationBar: View {
        @Environment(\.dismiss) private var dismiss

        var body: some View {
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .frame(width: 44, height: 44)
                        .tint(.black)
                }
                Spacer()
                Text("바로주문")
                    .font(.semiBold18)
                Spacer()

                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal, 8)
        }
    }
    
    
}




#Preview {
    MobileOrderDetailView()
}
