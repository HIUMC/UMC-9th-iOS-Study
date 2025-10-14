//
//  ReserveView.swift
//  MegaBox
//
//  Created by 박병선 on 9/30/25.
//
import SwiftUI

struct ReserveView: View {
    @Environment(NavigationRouter.self) var router
    @EnvironmentObject var viewModel: MovieViewModel

    @State private var isMovieSheetOn = false

    var body: some View {
        VStack(spacing: 0) {
            TopBarView
                .padding(.horizontal, -16)
            MovieSelectView
                .padding(.top, -40) 

            if viewModel.selectedMovie != nil {
                TheaterSelectView
            }
            if viewModel.showDate {
                WeekStripView(viewModel: _viewModel)
            }

            // 하단 상영 정보 섹션 (세 가지 모두 선택되면 노출)
            if viewModel.isShowtimeVisible {
                ShowtimeListSection
            }

            Spacer()
        }
        .padding(.horizontal, 16)
        .sheet(isPresented: $isMovieSheetOn) {
            MovieSheet(searchVM: MovieSearchViewModel()) { movie in
                // 시트에서 선택한 영화를 BookingView의 상태에 반영
                viewModel.selectedMovie = movie
            }
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
    }

    //MARK: - 영화 이름 - 전체 영화 바
    private var TopBarView: some View {
        HStack{
            Spacer()
            Text("영화별 예매")
                .font(.pretendardBold(22))
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .padding(.top, 71)
                .padding(.bottom, 10)
            Spacer()
        }
        .background(.purple03)
        .ignoresSafeArea()
    }

    private var MovieSelectView: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: 26, height: 24)
                        .foregroundStyle(.orange)
                    Text("15")
                        .font(.pretendardBold(18))
                        .foregroundStyle(.white)
                }
                .padding(.trailing, 39)

                Text(viewModel.selectedMovie?.title ?? "영화 이름")
                    .font(.pretendardBold(18))
                    .foregroundStyle(.black)
                    .frame(width: 238)
                Spacer()
                Button(action: {isMovieSheetOn = true }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray02)
                            .frame(width: 69, height: 30)
                            .background(.white)
                        Text("전체영화")
                            .font(.pretendardSemiBold(14))
                            .foregroundStyle(.black)
                    }
                }
            }
            .padding(.bottom, 20)

            //MARK: - 영화 스크롤 뷰
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(viewModel.movies) { movie in
                        MoviePosterButton(
                            movie: movie,
                            isSelected: (viewModel.selectedMovie?.id == movie.id) || (viewModel.selectedMovie?.title == movie.title),
                            onTap: {
                                if viewModel.selectedMovie?.id == movie.id {
                                    // 선택 해제
                                    viewModel.selectedMovie = nil
                                    viewModel.selectedTheaters.removeAll()
                                    viewModel.selectedDate = nil
                                } else {
                                    // 영화 선택
                                    viewModel.selectedMovie = movie
                                }
                            })
                    }
                }
                .frame(height: 100)
            }

        }
    }
}


//MARK: - 영화 포스터 뷰

struct MoviePosterButton: View {
    let movie: Movie
    let isSelected: Bool
    let onTap: () -> Void
    var body: some View {
        Button(action: onTap) {
            Image(movie.poster)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 62)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isSelected ? Color.purple03 : Color.clear, lineWidth: 2)
                )
                .padding(.bottom, 8)
        }
    }
}


//MARK: - 강남 홍대 신촌 버튼
private extension ReserveView {
    var TheaterSelectView : some View {
        HStack(spacing: 8) {
            ForEach(Theater.allCases, id: \.self) { t in
                let isOn = viewModel.selectedTheaters.contains(t)
                
                Button { ///토글
                    if isOn { viewModel.selectedTheaters.remove(t) }
                    else    { viewModel.selectedTheaters.insert(t) }
                } label: {
                    Text(t.rawValue)
                        .padding(.horizontal, 14).padding(.vertical, 8)
                        .background(isOn ? Color.purple03 : Color.gray01)
                        .foregroundStyle(isOn ? Color.white : Color.gray05)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .disabled(!viewModel.showTheater)
                .allowsHitTesting(viewModel.showTheater)
                .opacity(viewModel.showTheater ? 1 : 0.4)
            }
            Spacer()
        }
    }

    //MARK: - 극장 선택 뷰
    var ShowtimeListSection: some View {
        VStack(alignment: .leading, spacing: 16) {

            // 신촌만 선택된 경우: 상영시간표 없음 메시지
            if viewModel.selectedTheaters.count == 1,
               viewModel.selectedTheaters.contains(.shinchon) {
                Text("선택한 극장에 상영시간표가 없습니다")
                    .font(.pretendardSemiBold(14))
                    .foregroundStyle(.gray05)
                    .padding(.vertical, 8)
            } else {
                // 나머지 경우엔 상영 시간 표시 (신촌은 빼야되는디)
                ForEach(Array(viewModel.showtimes.keys.sorted { $0.rawValue < $1.rawValue }), id: \.self) { theater in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(theater.rawValue)
                            .font(.pretendardBold(18))
                            .foregroundStyle(.black)

                        let items = viewModel.showtimes[theater] ?? []
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(items) { s in
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(timeString(s.start)) // 11:30
                                            .font(.pretendardBold(18))
                                            .foregroundStyle(.black)
                                        Text("~ \(timeString(s.end))")
                                            .font(.pretendardSemiBold(12))
                                            .foregroundStyle(.gray05)
                                        HStack(spacing: 2) {
                                            Text("\(s.remaining)")
                                                .font(.pretendardSemiBold(12))
                                                .foregroundStyle(.purple03)
                                            Text("/\(s.capacity)")
                                                .font(.pretendardSemiBold(12))
                                                .foregroundStyle(.gray03)
                                        }
                                    }
                                    .padding(12)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.gray02, lineWidth: 1)
                                    )
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding(.top, 16)
    }

    private func timeString(_ d: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "HH:mm"
        return f.string(from: d)
    }
}


//MARK: - 날짜

private struct WeekStripView: View {
    @EnvironmentObject var viewModel: MovieViewModel

    var body: some View {
            // 주간 날짜 칩
        HStack(spacing: 8) {
            ForEach(weekDays, id: \.self) { d in
                let isSelected = viewModel.selectedDate.map { Calendar.current.isDate($0, inSameDayAs: d) } ?? false
                DateChip(date: d, isSelected: isSelected) {
                    viewModel.selectedDate = d
                }
                .disabled(!viewModel.showDate)
          
            }
        }
        .frame(height: 92)
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }

    // 오늘 기준 7일
    private var weekDays: [Date] {
        let base = viewModel.selectedDate ?? Date()
        return makeWeek(from: base)
    }

    /// 기준 날짜가 속한 주의 7일
    private func makeWeek(from base: Date) -> [Date] {
        let cal = Calendar.current
        // 주 시작일 구하기 (사용자 지역의 firstWeekday 반영)
        let start: Date
        if let interval = cal.dateInterval(of: .weekOfYear, for: base) {
            start = interval.start
        } else {
            let weekday = cal.component(.weekday, from: base)
            let diff = (weekday - cal.firstWeekday + 7) % 7
            start = cal.date(byAdding: .day, value: -diff, to: base) ?? base
        }
        let startOfDay = cal.startOfDay(for: start)
        // 7일 생성
        return (0..<7).compactMap { cal.date(byAdding: .day, value: $0, to: startOfDay) }
    }
}


private struct DateChip: View {
    let date: Date
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        let cal = Calendar.current
        let isToday = cal.isDateInToday(date)
        let isTomorrow = cal.isDateInTomorrow(date)
        let weekday = cal.component(.weekday, from: date)

        let mainText = isToday ? monthDayString : dayNumberString
        let subText  = isToday ? "오늘" : (isTomorrow ? "내일" : weekdayShortKOR)

        let numberColor: Color = {
            if isSelected { return .white }
            if weekday == 1 { return .red }      // 일요일
            if weekday == 7 { return .tag }     // 청록색
            return .primary
        }()

        return Button(action: onTap) {

            VStack(spacing: 6) {
                Text(mainText)
                    .font(.pretendardBold(22))
                    .foregroundStyle(numberColor)

                if isToday {
                    Text("오늘")
                        .font(.pretendardSemiBold(16))
                } else {
                    Text(subText)
                        .font(.pretendardSemiBold(16))
                        .foregroundStyle(isSelected ? .white.opacity(0.95) : .gray)
                }
            }
            .foregroundStyle(numberColor)
            .frame(width: 55, height: 60)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? Color.purple03 : .clear)

            )
        }
        .buttonStyle(.plain)
    }

    private var dayNumberString: String {
        String(Calendar.current.component(.day, from: date))
    }
    private var monthDayString: String {
        let f = DateFormatter()
        f.dateFormat = "M.d"
        return f.string(from: date)
    }
    private var weekdayShortKOR: String {
        let f = DateFormatter()
        f.locale = Locale(identifier: "ko_KR")
        f.dateFormat = "E"
        return f.string(from: date)
    }
}

#Preview {
    ReserveView()
        .environment(NavigationRouter())
        .environmentObject(MovieViewModel())
}
