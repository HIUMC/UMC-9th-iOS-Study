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
    
    
    var body: some View {
        if !viewModel.availableDates.isEmpty {
            VStack {
                HStack(spacing: 5) {
                    ForEach(viewModel.availableDates, id: \.self) { date in
                        Button( action: { viewModel.selectedDate = date } ) {
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: 50, height: 53)
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



