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
        HStack(spacing: 2) {
            ForEach(Array(viewModel.currentWeekDates().enumerated()), id: \.element.id) { index, day in
                let isSelected = Calendar.current.isDate(day.date, inSameDayAs: viewModel.selectedDate)
                let weekday = Calendar.current.component(.weekday, from: day.date)
                
                Button(action:{
                    guard theaterVM.isEnabled else { return } // 극장 선택 후에만 선택 가능
                    viewModel.selectDate(day.date)
                    theaterVM.selectedDate = day.date
                  
                }){
                    VStack(spacing : 5) {
                            Text(formattedDate(day.date, isToday: index == 0))
                                .foregroundStyle(isSelected ? .white : .black)
                                .font(.PretendardBold18)
                            
                            Text(weekdayLabel(for: index, date: day.date))
                                .foregroundStyle(isSelected ? .white : (weekday == 1 ? Color.holiday : weekday == 7 ? Color.tag : Color.black))
                                .font(.PretendardsemiBold14)
                        }
                    }.frame(width: 55, height: 60)
                    .background(isSelected ? .purple03 : .white)
                    .cornerRadius(12)
            }
        }.padding(.horizontal, 16) // HStack에 패딩 적용
            .frame(maxWidth: .infinity, alignment: .leading) // 좌측 정렬
        // 왜 안댐?
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

func formattedDate(_ date: Date, isToday: Bool) -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    if isToday {
        formatter.dateFormat = "M.d" // 오늘은 월.일
    } else {
        formatter.dateFormat = "d"   // 나머지는 일만
    }
    return formatter.string(from: date)
}

struct CalenderView_Preview: PreviewProvider {
    static var previews: some View {
        let theaterVM = TheaterViewModel()
        devicePreviews {
            CalendarView(viewModel: CalendarViewModel(), theaterVM: theaterVM)
        }
    }
}
