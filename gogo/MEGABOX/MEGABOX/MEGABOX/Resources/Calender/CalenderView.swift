//
//  CalenderView.swift
//  MEGABOX
//
//  Created by 고석현 on 10/9/25.
//

import SwiftUI


struct Cell: View {
    
    var calendarDay: CalendarDay
    var isSelected: Bool
    @Bindable var viewModel: CalendarViewModel
    
    var body: some View {
        ZStack {
            if isSelected {
                Circle()
                    .fill(Color.yellow.opacity(0.6))
                    .frame(width: 26, height: 27)
                    .transition(.scale.combined(with: .opacity))
            }

            Text("\(calendarDay.day)")
                .font(.caption)
                .foregroundStyle(textColor)
                .animation(.easeInOut(duration: 0.2), value: viewModel.selectedDate)
        }
        .frame(height: 30)
        .onTapGesture {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0)) {
                viewModel.changeSelectedDate(calendarDay.date)
            }
        }
    }
    
    private var textColor: Color {
        if calendarDay.isCurrentMonth {
            return Color.black
        } else {
            return Color.gray.opacity(0.7)
        }
    }
}

struct CalendarView: View {
    
    @Bindable var viewModel: CalendarViewModel = .init()
    
    var body: some View {
        VStack(spacing: 24, content: {
            hedarController // 상단 월 변경 컨트롤러
            
            calendarView // 달력 본체
        })
        .padding(.vertical, 30)
        .padding(.horizontal, 16)
        .background(Color.white)
    }
    
    
    /// 상단 월 변경 컨틀롤러 뷰
    private var hedarController: some View {
        HStack(spacing: 47, content: {
            Button(action: {
                viewModel.changeMonth(by: -1)
            }, label: {
                Image(systemName: "chevron.left")
            })
            
            Text(viewModel.currentMonth, formatter: calendarHeaderDateFormatter)
                .font(.title3)
                .foregroundStyle(Color.black)
            
            
            Button(action: {
                viewModel.changeMonth(by: 1)
            }, label: {
                Image(systemName: "chevron.right")
            })
        })
    }
    
    /// 달력 본체 뷰
    private var calendarView: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 7), spacing: 5, content: {
            /// 요일 헤더 (일 ~ 토)
            ForEach(localizedWeekdaySymbols.indices, id: \.self) { index in
                Text(localizedWeekdaySymbols[index])
                    .foregroundStyle(index == 0 ? Color.red : index == 6 ? Color.blue : Color.gray) // 일요일, 토요일, 평일 색 따로 두기
                    .frame(maxWidth: .infinity)
                    .font(.caption)
            }
            .padding(.bottom, 30) // 요일 아래 여백
            
            ForEach(viewModel.daysForCurrentGrid(), id: \.id) { calendarDay in
                let isSelectedDate = viewModel.calendar.isDate(calendarDay.date, inSameDayAs: viewModel.selectedDate)
                Cell(calendarDay: calendarDay, isSelected: isSelectedDate, viewModel: viewModel)

            }
        })
        .frame(height: 250, alignment: .top)
    }
    
    /// 요일 이름 한글로 가져오기
    let localizedWeekdaySymbols: [String] = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.shortWeekdaySymbols ?? []
    }()
    
    /// 헤더 날짜 표시 포맷터
    let calendarHeaderDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM"
        return formatter
    }()
}

#Preview {
    CalendarView()
}
