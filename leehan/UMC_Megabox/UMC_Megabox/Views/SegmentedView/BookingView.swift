//
//  EventView.swift
//  UMC_Megabox
//
//  Created by 이한결 on 9/30/25.
//

import SwiftUI

struct BookingView: View {
    @StateObject private var viewModel = BookingViewModel()
    
    var body: some View {
        VStack {
            NavigationBar
            SelectMovieView(viewModel: viewModel)
            SelectTheaterView(viewModel: viewModel)
            SelectDateView(viewModel: viewModel)
            
            Spacer()
        }
    }
    
    private var NavigationBar: some View {
        Rectangle()
            .frame(width: 440, height: 125)
            .ignoresSafeArea()
            .foregroundStyle(.purple03)
            .overlay(alignment: .bottom) {
                Text("영화별 예매")
                .font(.PretendardBold(size: 22))
                .foregroundStyle(.white)
                .padding(.bottom, 15)
            }
    }
    
    
    
    
}

#Preview {
    BookingView()
}
