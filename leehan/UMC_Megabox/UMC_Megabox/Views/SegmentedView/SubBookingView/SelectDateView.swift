//
//  SelectDateView.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/6/25.
//

import SwiftUI
import Foundation

struct SelectDateView: View {
    
    @ObservedObject var viewModel: BookingViewModel
    let columns = [GridItem(.fixed(75)), GridItem(.fixed(75)), GridItem(.fixed(75)), GridItem(.fixed(75))]
    
    var body: some View {
        if !viewModel.availableDates.isEmpty {
            VStack {
                HStack(spacing: 5) {
                    ForEach(viewModel.availableDates, id: \.self) { date in
                        Button( action: { viewModel.selectedDate = date } ) {
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: 55, height: 60)
                                .foregroundStyle(viewModel.selectedDate == date ? .purple03 : Color.clear)
                                .overlay( VStack {
                                    Spacer()
                                    Text(formatDate(date, format: "d"))
                                        .font(.PretendardBold(size: 18))
                                        .foregroundStyle(viewModel.selectedDate == date ? .white : .black)
                                    Spacer().frame(width: 4)
                                    Text(formatDate(date, format: "E"))
                                        .font(.PretendardSemiBold(size: 14))
                                        .foregroundStyle(viewModel.selectedDate == date ? .white : .gray03)
                                    Spacer()
                                })
                        }
                            
                    }
                } // end of HStack
                
                Spacer().frame(width: 49)
                
                if !(viewModel.selectedDate == nil) {
                    VStack {
                        HStack {
                            Text(viewModel.selectedMovie?.name ?? "")
                                .frame(width: 408, height: 24)
                                .font(.PretendardBold(size: 18))
                                .foregroundStyle(.black)
                            Spacer()
                        }
                        Spacer().frame(height: 21)
                        HStack {
                            Text("크리클라이너 1관")
                                .font(.PretendardBold(size: 18))
                                .foregroundStyle(.black)
                            Spacer()
                            Text("2D")
                                .font(.PretendardSemiBold(size: 14))
                                .foregroundStyle(.black)

                        }
                        
                        Spacer().frame(height: 21)
                        // TODO: showtime 더미데이터와 바인딩 제대로 할 것
                        LazyVGrid(columns: columns) {
                            ForEach(viewModel.showtimes) { showtime in
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.gray02, lineWidth: 1)
                                    .foregroundStyle(.clear)
                                    .overlay( VStack {
                                        Spacer()
                                        
                                        Text(showtime.time)
                                            .font(.PretendardBold(size: 18))
                                            .foregroundStyle(.black)
                                        
                                        Spacer().frame(height: 25)
                                        
                                        HStack {
                                            Text("\(showtime.availableSeats) ")
                                                .font(.PretendardSemiBold(size: 14))
                                                .foregroundStyle(.purple03)
                                            Spacer().frame(height: 4)
                                            Text("/ \(showtime.totalSeats)")
                                                .font(.PretendardSemiBold(size: 14))
                                                .foregroundStyle(.gray03)
                                        }
                                        
                                        Spacer()
                                    })
                            }
                        }
                        
                    }
                    
                }
            }
        }
    }
    
    private func formatDate(_ date: Date, format: String) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            formatter.locale = Locale(identifier: "ko_KR") // 한국어로 요일 표시
            return formatter.string(from: date)
        }
}

#Preview {
    SelectDateView(viewModel: BookingViewModel())
}
