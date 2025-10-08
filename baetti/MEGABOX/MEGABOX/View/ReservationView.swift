//
//  ReservationView.swift
//  MEGABOX
//
//  Created by 박정환 on 10/8/25.
//

import SwiftUI

struct ReservationView: View {
    @StateObject private var viewModel = ReservationViewModel()
    @StateObject private var movieSheetVM = MovieSheetViewModel()
    @State private var showMovieSheet = false
    
    var body: some View {
        VStack(spacing: 0) {
            headerView
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    moviePickerSection
                    theaterPickerSection
                    datePickerSection
                    scheduleSection
                    Spacer(minLength: 24)
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
            }
        }
        .ignoresSafeArea(edges: .top)
        .sheet(isPresented: $showMovieSheet) {
            MovieSheetView(viewModel: movieSheetVM)
                .presentationDetents([.large])   // iOS 16 이상 시트 높이 옵션
        }
        .onChange(of: movieSheetVM.selectedMovie) { oldValue, newValue in
            guard let movie = newValue else { return }
            if let idx = viewModel.movies.firstIndex(where: { $0.title == movie.title }) {
                withAnimation(.easeInOut) {
                    viewModel.selectMovie(at: idx)
                }
            }
            // 선택 반영 후 시트 닫기
            if showMovieSheet { showMovieSheet = false }
        }
    }

    // Header (보라색 배경 + 타이틀)
    private var headerView: some View {
        ZStack(alignment: .bottomLeading) {
            Rectangle()
                .fill(Color.purple03)
                .frame(height: 120)
                .overlay(alignment: .center) {
                    Text("영화별 예매")
                        .font(.bold22)
                        .foregroundColor(.white)
                        .padding(.top, 60)
                }
        }
    }

    // 영화 선택 섹션
    private var moviePickerSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(alignment: .center) {
                if let _ = viewModel.selectedMovieIndex {
                    Text("15")
                        .font(.bold18)
                        .foregroundColor(.white)
                        .frame(width: 24, height: 26)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color.orange)
                        )
                }
                Text(viewModel.currentMovieTitle)
                    .font(.bold18)
                Spacer()
                Button {
                    showMovieSheet = true
                } label: {
                    Text("전체영화")
                        .font(.semiBold14)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .foregroundColor(Color.black)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray02, lineWidth: 1)
                        )
                }
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(viewModel.movies.indices, id: \.self) { idx in
                        let item = viewModel.movies[idx]
                        let isSelected = (viewModel.selectedMovieIndex == idx)
                        Button {
                            withAnimation(.easeInOut) { viewModel.selectMovie(at: idx) }
                        } label: {
                            posterView(named: item.poster)
                                .frame(width: 62, height: 89)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(isSelected ? Color.purple03 : Color.clear, lineWidth: 2)
                                )
                        }
                    }
                }
            }
        }
    }

    // 극장 선택 섹션
    private var theaterPickerSection: some View {
        HStack(spacing: 8) {
            ForEach(viewModel.theaters, id: \.self) { theater in
                let isSelected = viewModel.selectedTheaters.contains(theater)
                Button {
                    withAnimation(.easeInOut) {
                        viewModel.toggleTheater(theater)
                    }
                } label: {
                    Text(theater)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(isSelected ? .white : .primary)
                        .padding(.horizontal, 13)
                        .padding(.vertical, 6)
                        .background(
                            Capsule().fill(isSelected ? Color.purple03 : Color.gray01)
                        )
                }
            }
        }
        .disabled(!viewModel.isTheaterEnabled)
    }

    // 날짜 선택 섹션
    private var datePickerSection: some View {
        HStack(spacing: 5) {
            ForEach(viewModel.weekDays, id: \.self) { day in
                let isToday = Calendar.current.isDateInToday(day.date)
                let isSelected = day == viewModel.selectedDay
                
                Button {
                    withAnimation(.easeInOut) { viewModel.selectDay(day) }
                } label: {
                    VStack(spacing: 2) {
                        Text(day.dateLabel)
                            .font(.bold18)
                            .foregroundColor(isSelected ? .white : .primary)
                        Text(isToday ? "오늘" : day.weekdayLabel)
                            .font(.semiBold14)
                            .foregroundColor(isSelected ? .white : .gray03)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 64)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(isSelected ? Color.purple03 : Color.clear)
                    )
                }
            }
        }
        .disabled(!viewModel.isDateEnabled)
    }

    // 상영관/스케줄 섹션 (데모)
    private var scheduleSection: some View {
        Group {
            if viewModel.isShowtimeVisible {
                VStack(alignment: .leading, spacing: 16) {
                    let theaters = Array(viewModel.selectedTheaters).sorted()
                    ForEach(theaters, id: \.self) { (theater: String) in
                        VStack(alignment: .leading, spacing: 16) {
                            Text(theater)
                                .font(.bold22)
                                .padding(.top, 8)

                            let times = viewModel.showtimes[theater] ?? []
                            if times.isEmpty {
                                Text("상영 시간이 없습니다.")
                                    .font(.medium14)
                                    .foregroundColor(.gray03)
                            } else {
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 4), spacing: 12) {
                                    ForEach(times) { show in
                                        VStack(spacing: 4) {
                                            Text(show.time)
                                                .font(.semiBold16)
                                            Text("~00:00")
                                                .font(.regular12)
                                                .foregroundColor(.gray03)
                                            Text(show.seats)
                                                .font(.regular12)
                                                .foregroundColor(.purple03)
                                        }
                                        .frame(height: 72)
                                        .frame(maxWidth: .infinity)
                                        .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray02, lineWidth: 1))
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func posterView(named: String) -> some View {
        if UIImage(named: named) != nil {
            Image(named)
                .resizable()
                .scaledToFill()
        } else {
            // Placeholder if asset is missing
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .overlay(
                    Image(systemName: "film")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.gray)
                )
        }
    }
}

#Preview {
    ReservationView()
}
