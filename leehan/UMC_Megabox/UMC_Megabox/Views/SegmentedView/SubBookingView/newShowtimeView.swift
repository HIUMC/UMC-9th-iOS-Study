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
            if !(viewModel.selectedDate == nil) {
                VStack(spacing: 21) {
                    HStack {
                        Text(viewModel.selectedTheater?.name ?? "")
                            .frame(height: 24)
                            .font(.PretendardBold(size: 18))
                            .foregroundStyle(.black)
                        Spacer()
                    }
                    
                    if viewModel.isLoading {
                        
                        ProgressView()
                    }
                    // 에러가 생긴 경우
                    else if let message = viewModel.errorMessage {
                        Text(message)
                            .foregroundStyle(.gray02)
                    }
                    // 로딩중도 아니고 에러도 없음 + 날짜 선택도 완료함
                    else if !viewModel.availableDates.isEmpty && !(viewModel.selectedTheater == nil) {
                        
                        ForEach(viewModel.showtimes) { item in
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
                                            } // end of VStack
                                            
                                        } // end of ZStack
                                        
                                    } // end of Button
    
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    newShowtimeView(viewModel: BookingViewModel())
}
