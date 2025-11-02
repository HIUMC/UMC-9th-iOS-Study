//
//  newShowtimeView.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/29/25.
//

import SwiftUI

struct newShowtimeView: View {
    @ObservedObject var viewModel: BookingViewModel
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView(.vertical) {
            
            if viewModel.isLoading {
                ProgressView()
            }
            // 에러가 생긴 경우
            else if let message = viewModel.errorMessage {
                Text(message)
                    .foregroundStyle(.gray02)
            }
            // 로딩중도 아니고 에러도 없음 + 날짜 선택도 완료함
            else if !viewModel.availableDates.isEmpty && !viewModel.selectedTheaters.isEmpty {
                
                VStack(alignment: .leading, spacing: 21) {
                    ForEach(viewModel.groupedItems) { area in
                        
                        HStack {
                            Text(area.area) // 극장 지역 이름
                                .frame(height: 24)
                                .font(.PretendardBold(size: 18))
                                .foregroundStyle(.black)
                            Spacer()
                        }
                        
                        ForEach(area.items) { item in
                            
                            HStack {
                                Text(item.auditorium)
                                    .font(.PretendardBold(size: 18))
                                    .foregroundStyle(.black)
                                Spacer()
                                Text(item.format)
                                    .font(.PretendardSemiBold(size: 14))
                                    .foregroundStyle(.black)
                            }
                            
                            LazyVGrid(columns: columns, spacing: 10) {
                                ForEach(item.showtimes) { showtime in
                                    
                                    Button( action: { viewModel.selectedShowtime = showtime } ) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(viewModel.selectedShowtime == showtime ? .purple03 : .gray02, lineWidth: 1)
                                                .frame(width: 70, height: 80)
                                                .foregroundStyle(.clear)
                                            
                                            VStack {
                                                Text(showtime.start)
                                                    .font(.PretendardBold(size: 18))
                                                    .foregroundStyle(.black)
                                                
                                                
                                                HStack(spacing: 4) {
                                                    Text("\(showtime.available) ")
                                                        .font(.PretendardSemiBold(size: 14))
                                                        .foregroundStyle(.purple03)
                                                    Text("/ \(showtime.total)")
                                                        .font(.PretendardSemiBold(size: 14))
                                                        .foregroundStyle(.gray03)
                                                }.padding(.vertical, 8)
                                            }
                                        }
                                    }
                                } // end of ForEach(item.showtimes) -> 상영 일정 순회
                                
                                
                            }
                        } // end of ForEach(viewModel.groupedItems) -> 선택한 지역 순회
                        
                        
                    }
                } // end of ForEach(area.items) -> 상영관 이름과 format 순회
                
                
                
            }
        }
    }
}


#Preview {
    newShowtimeView(viewModel: BookingViewModel())
}
