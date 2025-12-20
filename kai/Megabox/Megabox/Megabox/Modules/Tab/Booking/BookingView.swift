//
//  BookingView.swift
//  Megabox
//
//  Created by 김지우 on 10/2/25.
//

import SwiftUI

struct BookingView: View {
    //   1. ViewModel을 ScheduleViewModel로 교체
    @StateObject private var vm = ScheduleViewModel()

    // “전체영화” 시트 표시
    @State private var showSearchSheet = false

    var body: some View {
        VStack(spacing: 0) {
            topNavigationBar

            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {

                    //   2. vm.allMovieSchedules를 사용하도록 바인딩 (수정됨)
                    moviePickerSection

                    //   3. vm.allAreaNames를 사용하도록 바인딩 (수정됨)
                    theaterPickerSection

                    //   4. vm.weekDates를 사용 (기존과 동일)
                    datePickerSection

                    //   5. vm.filteredAuditoriums를 사용하도록 (완전 재작성됨)
                    showtimeSection
                }
                .padding(.horizontal, 16)
            }
            .padding(.top, -30)
            .ignoresSafeArea(edges: .top)
        }
        .background(Color(.systemBackground).ignoresSafeArea())
        .sheet(isPresented: $showSearchSheet) {
            //   vm.allMovieSchedules (Movie 모델)를 전달
            MovieSearchSheet(movies: vm.allMovieSchedules) { selected in
                //   vm.selectedMovie에 (Movie 모델) 할당
                vm.selectedMovie = selected
            }
            .presentationDetents([.large])
        }
        .onAppear {
            //   뷰가 나타날 때 JSON 데이터 로드 실행
            vm.loadSchedules()
        }
    }
}

// MARK: - 상단 네비게이션바 (변경 없음)
private extension BookingView {
    var topNavigationBar: some View {
        ZStack(alignment: .bottom) {
            Color.purple03

            Text("영화별 예매")
                .font(.PretendardBold(size: 22))
                .foregroundColor(.white)
                .padding(.bottom, 10)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 98)
        .ignoresSafeArea(edges: .top)
    }
}


// MARK: - 영화 선택 섹션 (수정됨)
private extension BookingView {
    var moviePickerSection: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 8) {
                //   Movie 모델의 ageBadge (computed property) 사용
                if let age = vm.selectedMovie?.ageRating {
                    Text(age)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.white01)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(RoundedRectangle(cornerRadius: 4).fill(Color.orange))
                }

                Text(vm.selectedMovie?.title ?? "영화를 선택하세요")
                    .font(.system(size: 18, weight: .semibold))

                Spacer()

                Button("전체영화") {
                    showSearchSheet = true
                }
                .font(.system(size: 13))
                .foregroundColor(.gray)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )
            }

            // 가로 스크롤 무비 카드
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 14) {
                    //   vm.allMovieSchedules (Movie 모델) 사용
                    ForEach(vm.allMovieSchedules) { movie in
                        MoviePosterCard(
                            movie: movie, // Movie 모델 전달
                            isSelected: vm.selectedMovie == movie
                        ) {
                            vm.selectedMovie = movie
                        }
                    }
                }
                .padding(.vertical, 6)
            }
        }
    }
}

// MARK: - 극장 선택 섹션 (수정됨)
private extension BookingView {
    var theaterPickerSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            //   vm.allAreaNames (String 배열) 사용
            //   JSON에 지역이 2개뿐이라 임시로 3개씩 보이도록 수정
            let rows = vm.allAreaNames.chunks(ofCount: 3)
            
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(row, id: \.self) { areaName in
                        SelectableChip(
                            title: areaName,
                            //   vm.selectedAreaNames (Set<String>) 사용
                            isOn: vm.selectedAreaNames.contains(areaName),
                            action: { vm.toggleArea(areaName) } //   vm.toggleArea 호출
                        )
                        .disabled(!vm.canSelectTheater)
                        .opacity(vm.canSelectTheater ? 1.0 : 0.4)
                    }
                    Spacer() // 남는 공간 채우기
                }
            }
        }
    }
}
// Helper to split array into chunks for layout
extension Array {
    func chunks(ofCount chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map {
            Array(self[$0 ..< Swift.min($0 + chunkSize, self.count)])
        }
    }
}

// MARK: - 날짜 선택 섹션 (수정됨)
private extension BookingView {
    var datePickerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            ScrollView(.horizontal, showsIndicators: false) { //   7일이 넘을 수 있으므로 ScrollView로 감쌈
                HStack(spacing: 18) {
                    //   vm.weekDates 사용
                    ForEach(vm.weekDates, id: \.timeIntervalSince1970) { d in
                        DatePill(
                            date: d,
                            //   vm.isSameDay 헬퍼 사용
                            selected: vm.isSameDay(vm.selectedDate, d),
                            //   vm.isToday 헬퍼 사용
                            isToday: vm.isToday(d)
                        ) {
                            vm.selectedDate = d
                        }
                        .disabled(!vm.canSelectDate)
                        .opacity(vm.canSelectDate ? 1.0 : 0.4)
                    }
                }
            }
            .padding(.vertical, 2)
        }
    }
}


// MARK: - 상영관/시간 섹션 (완전 재작성됨)
private extension BookingView {
    var showtimeSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            //   vm.canShowShowtimes 플래그 사용
            if vm.canShowShowtimes {
                //   vm.selectedAreaNames (Set<String>) 사용
                ForEach(vm.selectedAreaNames.sorted(), id: \.self) { areaName in
                    
                    Section {
                        //   vm.filteredAuditoriums (Dictionary) 사용
                        let auditoriums = vm.filteredAuditoriums[areaName] ?? []
                        
                        if auditoriums.isEmpty {
                            //   기존 EmptyScheduleRow 재사용
                            EmptyScheduleRow(theaterName: areaName)
                        } else {
                            //   상영관 목록 (AuditoriumItem) 루프
                            ForEach(auditoriums) { auditorium in
                                //   새로 만든 'AuditoriumScheduleRow' 뷰 사용
                                AuditoriumScheduleRow(auditorium: auditorium)
                            }
                        }
                    } header: {
                        HStack {
                            Text(areaName) // 지역명 (예: "강남")
                                .font(.system(size: 16, weight: .semibold))
                            Spacer()
                        }
                        .padding(.top, 4)
                    }
                }
            } else {
                //   3가지 항목을 모두 선택하기 전의 플레이스홀더
                VStack(alignment: .center, spacing: 10) {
                    Spacer(minLength: 40)
                    Image(systemName: "film")
                        .font(.largeTitle)
                        .foregroundColor(.gray.opacity(0.5))
                    Text("영화, 극장, 날짜를 선택해주세요.")
                        .font(.PretendardSemiBold(size: 15))
                        .foregroundColor(.gray)
                    Spacer(minLength: 40)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

// MARK: - Subviews (수정 및 추가)

//   MoviePosterCard (수정됨)
//    'BookingMovie' -> 'Movie' 모델을 받도록 수정
private struct MoviePosterCard: View {
    let movie: Movie //   Movie 모델
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            ZStack(alignment: .bottom) {
                Image(movie.posterAsset) 
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 110)
                    .clipped()
                    .cornerRadius(10)

                if isSelected {
                    Text(movie.title) //   Movie.title
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.black.opacity(0.55))
                        )
                        .padding(.bottom, 6)
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? Color.purple03 : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
    }
}

//   SelectableChip (변경 없음)
private struct SelectableChip: View {
    let title: String
    let isOn: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(isOn ? .white : .gray)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(isOn ? Color.purple03 : Color(UIColor.systemGray6))
                )
        }
        .buttonStyle(.plain)
    }
}

//   DatePill (변경 없음)
// (내부 헬퍼 함수들은 ViewModel로 이동하지 않고 뷰 내부에 둬도 무방합니다)
private struct DatePill: View {
    let date: Date
    let selected: Bool
    let isToday: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Group {
                if selected {
                    VStack(spacing: 4) {
                        Text(monthDotDay(date))
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                        Text(isToday ? "오늘" : subtitle(date))
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    .frame(width: 58, height: 58)
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color.purple03)
                    )

                } else {
                    VStack(spacing: 6) {
                        Text(dayOnly(date))
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(dayColor(date))
                        Text(subtitle(date))
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    .frame(width: 36)
                }
            }
        }
        .buttonStyle(.plain)
    }
    
    // MARK: - Formatting & Helpers
    private func monthDotDay(_ d: Date) -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "M.d"
        return df.string(from: d)
    }

    private func dayOnly(_ d: Date) -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "d"
        return df.string(from: d)
    }

    private func subtitle(_ d: Date) -> String {
        let cal = Calendar.current
        if let tmr = cal.date(byAdding: .day, value: 1, to: Date()),
           cal.isDate(d, inSameDayAs: tmr) {
            return "내일"
        }
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "E"  // 일/월/화/...
        return df.string(from: d)
    }

    private func dayColor(_ d: Date) -> Color {
        let cal = Calendar.current
        let wd = cal.component(.weekday, from: d)
        if wd == 1 {          // 일요일
            return .red
        } else if wd == 7 {     // 토요일
            return Color.cyan
        } else {
            return .primary
        }
    }
}

//   AuditoriumScheduleRow (새로 추가됨)
//    상영관 정보(이름, 포맷)와 하위 시간표(ShowtimeChip)를 표시
private struct AuditoriumScheduleRow: View {
    let auditorium: AuditoriumItem
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // 상영관 이름, 포맷 (예: "크리클라이너 1관", "2D")
            HStack(spacing: 8) {
                Text(auditorium.name)
                    .font(.PretendardSemiBold(size: 15))
                    .foregroundColor(.primary)
                Text(auditorium.format)
                    .font(.PretendardRegular(size: 13))
                    .foregroundColor(.gray)
                Spacer()
            }
            
            // 상영 시간표 칩 (3열 그리드)
            LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                ForEach(auditorium.showtimes) { showtime in
                    ShowtimeChip(showtime: showtime)
                }
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(UIColor.systemGray6))
        )
    }
}

//   ShowtimeChip (새로 추가됨)
//    개별 상영 시간과 잔여 좌석을 표시
private struct ShowtimeChip: View {
    let showtime: Showtime
    
    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(ShowtimeChip.timeFormatter.string(from: showtime.start))
                .font(.PretendardBold(size: 16))
                .foregroundColor(.primary)
            
            Text("잔여 \(showtime.available)")
                .font(.PretendardRegular(size: 12))
                .foregroundColor(.purple03)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.gray.opacity(0.3))
        )
    }
}


//   EmptyScheduleRow (변경 없음)
private struct EmptyScheduleRow: View {
    let theaterName: String
    var body: some View {
        HStack {
            Text("[\(theaterName)] 상영시간표가 없습니다.")
                .font(.system(size: 14))
                .foregroundColor(.gray)
            Spacer()
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.25))
        )
    }
}

#Preview {
    BookingView()
}
