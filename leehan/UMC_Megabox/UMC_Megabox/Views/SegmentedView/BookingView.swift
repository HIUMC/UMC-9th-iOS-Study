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
        NavigationBar
        
        VStack {
            SelectMovieView(viewModel: viewModel)
            Spacer().frame(height: 20)
            SelectTheaterView(viewModel: viewModel)
            Spacer().frame(height: 32)
            SelectDateView(viewModel: viewModel)
            Spacer().frame(height: 21)
            newShowtimeView(viewModel: viewModel)
        }.padding(.horizontal)
            .onAppear {
            Task {
                await viewModel.fetchInfos()
            }
        }
    }
        
    
    private var NavigationBar: some View {
        Rectangle()
            .frame(width: 440, height: 120)
            .foregroundStyle(.purple03)
            .overlay(alignment: .bottom) {
                Text("영화별 예매")
                .font(.PretendardBold(size: 22))
                .foregroundStyle(.white)
                .padding(.bottom, 15)
            }
            .ignoresSafeArea()
    }
    
    
    
    
}

#Preview {
    BookingView()
}
