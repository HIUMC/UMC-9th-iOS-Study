//
//  ReservationView.swift
//  MEGABOX
//
//  Created by 고석현 on 10/10/25.
//

import SwiftUI

struct ReservationView: View {
    @Environment(NavigationRouter.self) var router
    @EnvironmentObject var viewModel: MovieViewModel
    @State private var isMovieSheetOn = false
    
    var body: some View {
        VStack(spacing: 0) {
            TopBar
                .padding(.horizontal, -16)
            
            // 영화 선택 섹션 (현재 선택된 영화 + 전체 영화 보기 버튼 + 포스터 리스트)
            MovieSelectionSection
                .padding(.top, -40)
            
            // 영화가 선택된 경우에만 극장 버튼이 활성화됨
            if viewModel.pickedMovie != nil {
                TheaterSelectionSection
            }
            
            // 영화 + 극장 선택 완료 시 날짜 선택 가능
            if viewModel.isDateActive {
                WeekSelectorView()
                    .environmentObject(viewModel)
            }
            
            // 세 가지(영화, 극장, 날짜)가 모두 선택되면 상영 시간 표시
            if viewModel.canDisplayShowtimes {
                ShowtimeSection
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
        // 영화 선택 시 나타나는 시트 (영화 전체 리스트)
        .sheet(isPresented: $isMovieSheetOn) {
            MovieSheetView(viewModel: MovieSearchViewModel()) { movie in
                viewModel.pickedMovie = movie
            }
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
    }
}

// MARK: - 상단 바
// 상단의 "영화별 예매" 타이틀 영역. 상태바 포함 전체 배경을 보라색으로 채움.
private extension ReservationView {
    var TopBar: some View {
        HStack {
            Spacer()
            Text("영화별 예매")
                .font(.PretendardBold(size:22))
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .padding(.top, 71)
                .padding(.bottom, 10)
            Spacer()
        }
        .background(.purple03)
        .ignoresSafeArea()
    }
}

// MARK: - 영화 선택 섹션
// 상단 포스터 스크롤 + 영화 이름 + 전체영화 버튼
// 사용자가 영화를 선택하거나 전체 영화 목록을 볼 수 있도록 하는 UI 영역
private extension ReservationView {
    var MovieSelectionSection: some View {
        VStack(spacing: 0) {
            // 상단의 영화 정보 영역
            HStack(spacing: 0) {
                // 연령제한 박스
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: 26, height: 24)
                        .foregroundStyle(.orange)
                    Text("15")
                        .font(.PretendardBold(size:18))
                        .foregroundStyle(.white)
                }
                .padding(.trailing, 39)
                
                // 영화 이름 표시 (선택된 영화가 없다면 기본 텍스트)
                Text(viewModel.pickedMovie?.title ?? "영화 이름")
                    .font(.PretendardBold(size:18))
                    .foregroundStyle(.black)
                    .frame(width: 238)
                Spacer()
                
                // 전체 영화 버튼 (시트로 연결)
                Button(action: { isMovieSheetOn = true }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray02)
                            .frame(width: 69, height: 30)
                            .background(.white)
                        Text("전체영화")
                            .font(.PretendardSemiBold(size:14))
                            .foregroundStyle(.black)
                    }
                }
            }
            .padding(.bottom, 20)
            
            // 가로 스크롤 영화 포스터 영역
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(viewModel.movies) { movie in
                        PosterButton(
                            movie: movie,
                            isSelected: viewModel.pickedMovie?.id == movie.id,
                            onTap: {
                                // 같은 영화를 다시 누르면 해제, 아니면 선택
                                if viewModel.pickedMovie?.id == movie.id {
                                    viewModel.pickedMovie = nil
                                    viewModel.chosenTheaters.removeAll()
                                    viewModel.pickedDate = nil
                                } else {
                                    viewModel.pickedMovie = movie
                                }
                            }
                        )
                    }
                }
                .frame(height: 100)
            }
        }
    }
}

// MARK: - 영화 포스터 버튼
// 포스터 하나를 보여주는 버튼 뷰
// 이 버튼은 영화 포스터를 눌렀을 때 선택 또는 해제되도록 하는 역할.
// 선택된 영화는 보라색 테두리가 생김.
private struct PosterButton: View {
    let movie: MovieModel
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            Image(movie.poster)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 62)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                // 선택된 경우 보라색 테두리 표시
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isSelected ? Color.purple03 : Color.clear, lineWidth: 2)
                )
                .padding(.bottom, 8)
        }
    }
}

// MARK: - 극장 선택 섹션
// 영화가 선택되어야 활성화되며, 여러 극장을 동시에 선택 가능
// 사용자가 원하는 극장을 선택하거나 해제할 수 있는 영역
private extension ReservationView {
    var TheaterSelectionSection: some View {
        HStack(spacing: 8) {
            ForEach(Theater.allCases, id: \.self) { theater in
                let isSelected = viewModel.chosenTheaters.contains(theater)
                Button {
                    // 선택된 극장은 다시 누르면 해제, 아니면 추가
                    if isSelected {
                        viewModel.chosenTheaters.remove(theater)
                    } else {
                        viewModel.chosenTheaters.insert(theater)
                    }
                } label: {
                    Text(theater.rawValue)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(isSelected ? Color.purple03 : Color.gray01)
                        .foregroundStyle(isSelected ? Color.white : Color.gray05)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                // 영화가 선택되어야만 버튼이 활성화되고 터치 가능
                .disabled(!viewModel.isTheaterActive)
                .allowsHitTesting(viewModel.isTheaterActive)
                .opacity(viewModel.isTheaterActive ? 1 : 0.4)
            }
            Spacer()
        }
    }
}

// MARK: - 상영 시간 섹션
// 영화, 극장, 날짜를 모두 선택했을 때만 표시됨
// 신촌만 선택한 경우 “상영시간표가 없습니다” 메시지를 표시
// 선택된 조건에 맞는 상영 시간표를 보여주는 영역
private extension ReservationView {
    var ShowtimeSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            if viewModel.chosenTheaters.count == 1,
               viewModel.chosenTheaters.contains(.shinchon) {
                // 신촌 극장만 선택 시 상영시간표가 없음을 알려줌
                Text("선택한 극장에 상영시간표가 없습니다")
                    .font(.PretendardSemiBold(size:14))
                    .foregroundStyle(.gray05)
                    .padding(.vertical, 8)
            } else {
                // 각 극장별 상영 시간 표시
                ForEach(Array(viewModel.showtimeSchedule.keys.sorted { $0.rawValue < $1.rawValue }), id: \.self) { theater in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(theater.rawValue)
                            .font(.PretendardBold(size:18))
                            .foregroundStyle(.black)
                        
                        let showtimes = viewModel.showtimeSchedule[theater] ?? []
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(showtimes) { s in
                                    // 개별 상영 시간 카드
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(timeString(s.start))
                                            .font(.PretendardBold(size:18))
                                            .foregroundStyle(.black)
                                        Text("~ \(timeString(s.end))")
                                            .font(.PretendardSemiBold(size:12))
                                            .foregroundStyle(.gray05)
                                        HStack(spacing: 2) {
                                            Text("\(s.remaining)")
                                                .font(.PretendardSemiBold(size:12))
                                                .foregroundStyle(.purple03)
                                            Text("/\(s.capacity)")
                                                .font(.PretendardSemiBold(size:12))
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
    
    // 시간을 "HH:mm" 형식으로 변환하는 함수
    // Date 타입을 사람이 읽기 쉬운 시간 문자열로 변환
    private func timeString(_ d: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "HH:mm"
        return f.string(from: d)
    }
}

// MARK: - 날짜 선택 뷰
// 오늘 기준 7일간의 날짜를 보여주는 뷰
// 가로 스크롤로 이동 가능, 포스터와 여백 정렬을 맞춤
// 사용자가 원하는 날짜를 선택할 수 있도록 하는 UI
private struct WeekSelectorView: View {
    @EnvironmentObject var viewModel: MovieViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(viewModel.weekDays, id: \.self) { day in
                    // 현재 선택된 날짜와 비교해서 선택 여부 결정
                    let isSelected = viewModel.pickedDate.map {
                        Calendar.current.isDate($0, inSameDayAs: day)
                    } ?? false

                    DateButton(date: day, isSelected: isSelected) {
                        // 날짜 선택 시 뷰모델에 반영
                        viewModel.pickedDate = day
                    }
                    // 영화와 극장이 선택되어야 날짜 선택 가능
                    .disabled(!viewModel.isDateActive)
                }
            }
            .padding(.horizontal, 16)   // 영화 포스터 뷰와 동일한 여백
            .padding(.vertical, 8)
        }
        .frame(height: 100)
    }
}

// MARK: - 날짜 버튼
// 각 날짜 하나를 나타내는 뷰
// 오늘, 내일, 주말 색상 구분 포함
// 날짜 칩을 눌러서 선택할 수 있음
private struct DateButton: View {
    let date: Date
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        let cal = Calendar.current
        // 날짜 계산
        // 오늘인지 확인
        let isToday = cal.isDateInToday(date)
        // 내일인지 확인
        let isTomorrow = cal.isDateInTomorrow(date)
        // 요일 숫자 (1=일요일, 7=토요일)
        let weekday = cal.component(.weekday, from: date)
        
        // 메인 텍스트(날짜 숫자)와 서브텍스트(요일 or 오늘/내일)
        // 오늘은 월.일 형식, 그 외는 그냥 일(day) 숫자 표시
        let main = isToday ? monthDayString : dayString
        // 서브텍스트는 오늘, 내일, 혹은 요일 한글 약어
        let sub = isToday ? "오늘" : (isTomorrow ? "내일" : weekdayKOR)
        
        // 선택 상태 및 요일에 따라 색상 다르게 설정
        // 선택된 경우 흰색 텍스트
        // 일요일은 빨간색, 토요일은 청록색, 나머지는 기본 색상
        let textColor: Color = {
            if isSelected { return .white }
            if weekday == 1 { return .red }   // 일요일 빨간색
            if weekday == 7 { return .tag }   // 토요일 청록색
            return .primary
        }()
        
        // 버튼 자체
        Button(action: onTap) {
            VStack(spacing: 6) {
                Text(main)
                    .font(.PretendardBold(size:22))
                    .foregroundStyle(textColor)
                Text(sub)
                    .font(.PretendardSemiBold(size:16))
                    // 선택된 경우 서브텍스트도 흰색에 가깝게, 아니면 회색
                    .foregroundStyle(isSelected ? .white.opacity(0.95) : .gray)
            }
            // 날짜 칩 스타일
            .frame(width: 50, height: 60)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    // 선택된 경우 보라색 배경, 아니면 투명
                    .fill(isSelected ? Color.purple03 : .clear)
            )
        }
        .buttonStyle(.plain)
    }
    
    // 날짜 숫자 (예: 25)
    private var dayString: String {
        String(Calendar.current.component(.day, from: date))
    }
    // 월.일 형식 문자열 (예: 6.25)
    private var monthDayString: String {
        let f = DateFormatter()
        f.dateFormat = "M.d"
        return f.string(from: date)
    }
    // 요일 한글  (예: 월, 화, 수)
    private var weekdayKOR: String {
        let f = DateFormatter()
        f.locale = Locale(identifier: "ko_KR")
        f.dateFormat = "E"
        return f.string(from: date)
    }
}

// MARK: - 프리뷰
#Preview {
    ReservationView()
        .environment(NavigationRouter())
        .environmentObject(MovieViewModel())
}
