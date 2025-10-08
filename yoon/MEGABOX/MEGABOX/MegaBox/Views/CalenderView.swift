//
//  CalenderView.swift
//  MEGABOX
//
//  Created by 정승윤 on 10/8/25.
//

import Foundation
import SwiftUI

struct CalendarView: View {
    @Bindable var viewModel: CalendarViewModel = .init()
    @ObservedObject var theaterVM: TheaterViewModel
    var body: some View {
        HStack(spacing: 10) {
            ForEach(Array(viewModel.currentWeekDates().enumerated()), id: \.element.id) { index, day in
                let isSelected = Calendar.current.isDate(day.date, inSameDayAs: viewModel.selectedDate)
                let weekday = Calendar.current.component(.weekday, from: day.date)
                
                ZStack {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.purple03)
                            .frame(width: 55, height: 60)
                    }
                    VStack(spacing : 4) {
                        Text(day.date, formatter: monthDayFormatter)
                            .foregroundStyle(isSelected ? .white : .black)
                            .font(.PretendardBold18)
                        
                        Text(weekdayLabel(for: index, date: day.date))
                            .foregroundStyle(isSelected ? .white : (weekday == 1 ? Color.holiday : weekday == 7 ? Color.tag : Color.black))
                            .font(.PretendardsemiBold14)
                    }
                    .onTapGesture {
                        guard theaterVM.isEnabled else { return } // 극장 선택 후에만 선택 가능
                        viewModel.selectDate(day.date)
                    }
                }
            }
        }
    }
    let monthDayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "M.d" // ex: 9.22
        return formatter
    }()

    let weekdayFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ko_KR")
            formatter.dateFormat = "E" // 요일만 표시 (월, 화, 수...)
            return formatter
        }()
}

private func weekdayLabel(for index: Int, date: Date) -> String {
       switch index {
       case 0: return "오늘"
       case 1: return "내일"
       default:
           let formatter = DateFormatter()
           formatter.locale = Locale(identifier: "ko_KR")
           formatter.dateFormat = "E"
           return formatter.string(from: date)
       }
   }

   let monthDayFormatter: DateFormatter = {
       let formatter = DateFormatter()
       formatter.dateFormat = "M.d"
       return formatter
   }()


struct CalenderView_Preview: PreviewProvider {
    static var previews: some View {
        let theaterVM = TheaterViewModel()
        devicePreviews {
            CalendarView(viewModel: CalendarViewModel(), theaterVM: theaterVM)
        }
    }
}
