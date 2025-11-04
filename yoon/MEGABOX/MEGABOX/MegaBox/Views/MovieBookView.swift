//
//  MovieBook.swift
//  MEGABOX
//
//  Created by 정승윤 on 10/7/25.
//

import Foundation
import SwiftUI
import Combine

//MARK: 영화 문자열 비교해서 시간표 보여주기
// 더 나은 방법이 있을까

struct MovieBookView: View {
    @StateObject private var calendarVM = CalendarViewModel()
    @StateObject private var scheduleVM = ScheduleViewModel()
    @Environment(NavigationRouter.self) var router
    @Environment(MovieViewModel.self) var movieViewModel
    @EnvironmentObject var theaterVM: TheaterViewModel
    @State private var selectedMovie: MovieModel? = nil
    @State private var isShowingSheet: Bool = false
    @Binding var selectTheaters: Set<Theaters>
    
    init(selectTheaters: Binding<Set<Theaters>>) {
        self._selectTheaters = selectTheaters
        // VM 초기화 시점을 제어할 수 없을 때는 onAppear에서 설정해도 무방하나,
        // 현재는 @StateObject로 선언되어 있으므로, onAppear에서 설정하겠습니다.
    }
    
    var body: some View {
        // 바디안에 보이는것만 뷰에서 구현
        VStack{
            
            NavigationBar
            
            if let movie = displayMovie {
                MovieNavigationBar( movie: movie, isShowingSheet: $isShowingSheet)
            }// display의 결과값을 movie 로 선언하여 MovieNavigationBar에 사용
            
            MovieList(selectedMovie: $selectedMovie){updateShowtimes()}
                .onChange(of: selectedMovie) { oldValue, newValue in
                    theaterVM.selectedMovie = newValue
                    updateShowtimes()  // 선택된 영화 변경 시 시간표 갱신
                }
            // 선택된 영화가 바뀔 때마다 onChange 동작
            // theaterVM.selectedMovie 갱신
            // TheaterViewModel의 selectedMovie 변경을 반영
            
            Spacer().frame(height: 32)
            
            TheaterButton()
            // selectedMovie 변경사항을 isEnabled에 반영
            
            Spacer().frame(height: 29)
            
            CalendarView(viewModel: calendarVM, theaterVM: theaterVM)
            
            Spacer().frame(height:40)
            
            if theaterVM.ShowTheaterInfo {
                TheaterInfoView(showtimes: scheduleVM.currentShowtimes)
            }
            
            Spacer()
            
        }.onChange(of: theaterVM.selectedDate) {
            updateShowtimes()
        }
        .onChange(of: theaterVM.selectedTheater) {
            updateShowtimes()
        }
        .onAppear {
            if selectedMovie == nil, let firstMovie = movieViewModel.movies.first {
                selectedMovie = firstMovie
                
                // 더 공부
                Task {
                    // json 연결
                    await scheduleVM.fetchSchedule()
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                    
                    if let fixedDate = dateFormatter.date(from: "2025-09-22") {
                        theaterVM.selectedDate = fixedDate
                    }
                    
                    // 스케줄 로드와 날짜 초기화가 모두 Task 내에서 완료된 후 호출
                    updateShowtimes()
                } // Task 끝
            }
        }
        .sheet(isPresented: $isShowingSheet){
            MovieSearchView()
        }
        .padding(.horizontal,16)
        
    }
    private var NavigationBar: some View {
        VStack{
            Spacer()
            Text("영화별 예매")
                .font(.PretendardBold22)
                .foregroundStyle(.white)
                .padding(.bottom,10)
        }.ignoresSafeArea(.container,edges: .top)
            .frame(width: 440, height: 42)
            .background(Color.purple03)
    }
    
    struct AgeBadge: View {
        let movie: MovieModel
        var body: some View {
            ZStack{
                Rectangle()
                    .frame(width: 26,height: 24)
                    .foregroundStyle(.orange)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                Text(movie.age)
                    .font(.PretendardBold18)
                    .foregroundStyle(.white)
            }
        }
    }
    
    private var displayMovie: MovieModel? {
        selectedMovie ?? movieViewModel.movies.first
    } // 영화 선택하면 그 영화 정보. 아니면 첫번째 영화 정보
    
    struct MovieNavigationBar: View {
        let movie: MovieModel
        @Binding var isShowingSheet: Bool
        var body: some View {
            HStack {
                AgeBadge(movie: movie)
                Spacer().frame(width:37)
                Text(movie.name).font(.PretendardBold18).foregroundStyle(.black)
                Spacer()
                Button(action:{
                    isShowingSheet.toggle()
                }) {
                    Text("전체영화")
                        .padding(10)
                        .font(.PretendardsemiBold14)
                        .foregroundStyle(.black)
                        .frame(width:69,height: 30)
                        .background{RoundedRectangle(cornerRadius: 8).stroke(.gray02, lineWidth: 1)}
                    
                }
            }
        }
    }
    
    
    struct MovieCard: View {
        @Environment(NavigationRouter.self) var router
        @Binding var selectedMovie: MovieModel?
        let movie: MovieModel
        let onSelect: () -> Void
        
        private var isSelected: Bool {
            selectedMovie?.id == movie.id
        }// 내가 선택한 영화가 맞는지 확인
        
        var body: some View {
            Image(movie.posterName)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .frame(width: 62, height: 89)
                .overlay (RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        isSelected ? Color.purple03 : Color.clear,
                        lineWidth: 2 // 테두리 두께
                    ) // 내가 클릭한 영화에만 테두리 표시
                )
                .onTapGesture {
                    selectedMovie = movie
                    onSelect()
                }
            // 클릭한 영화를 selectedMovie로 설정
            
        }
    }
    
    struct MovieList: View {
        @Environment(MovieViewModel.self) var movieViewModel
        @Binding var selectedMovie: MovieModel?
        let updateShowtimes: () -> Void
        var body: some View {
            ScrollView(.horizontal, showsIndicators: false, content: {
                LazyHStack(spacing:8){
                    ForEach(movieViewModel.movies) { movie in MovieCard(selectedMovie: $selectedMovie,movie: movie){updateShowtimes()}}
                }.frame(height: 89)
            }
            )
        }
    }
    
    struct TheaterButton: View {
        @EnvironmentObject var theaterVM: TheaterViewModel
        
        var body: some View {
            HStack(spacing: 10) {
                ForEach(Theaters.allCases, id: \.self) { tab in
                    Button(action: {
                        theaterVM.selectTheater(tab)
                        print("현재 선택 극장:", theaterVM.selectedTheater.map { $0.rawValue })
                    }) {
                        Text(tab.rawValue)
                            .font(.PretendardsemiBold16)
                            .foregroundStyle(theaterVM.selectedTheater.contains(tab) ? .white : .gray05)
                            .frame(width: 55, height: 35)
                            .background(theaterVM.selectedTheater.contains(tab) ? .purple03 : .gray01)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                }
                Spacer()
            }
        }
    }
    
    private func updateShowtimes() {
        // 1. 선택된 극장 Set<Theaters>를 [String] 배열로 변환
        let selectedTheaterNames: [String] = theaterVM.selectedTheater.map { $0.rawValue }
        
        // 2. ViewModel의 필터링 함수 호출
        // 이 함수를 호출하여 scheduleVM.currentShowtimes 속성을 업데이트합니다.
        scheduleVM.applyFilterAndUpdateState(
            movie: selectedMovie,
            date: theaterVM.selectedDate,
            theaters: selectedTheaterNames
        )
    }
    
}
    // 영화 이름, 극장 대조하여 시간표 출력
    // MovieBookView 내에서
    
struct MovieBookView_Preview: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }

    struct PreviewWrapper: View {
        @State private var selectTheaters: Set<Theaters> = [.gangnam]
        @StateObject private var theaterVM: TheaterViewModel = {
            let vm = TheaterViewModel()
            vm.selectedMovie = MovieModel(
                posterName: "f1", secPosterName: "",
                name: "F1 더 무비", engname: "F1 The Movie",
                performance: "50", age: "12"
            )
            vm.selectedTheater = [.gangnam]
            vm.selectedDate = Date()
            return vm
        }()

        var body: some View {
            devicePreviews {
                MovieBookView(selectTheaters: $selectTheaters)
                    .environment(NavigationRouter())
                    .environment(MovieViewModel())
                    .environmentObject(theaterVM)
            }
        }
    }
}


