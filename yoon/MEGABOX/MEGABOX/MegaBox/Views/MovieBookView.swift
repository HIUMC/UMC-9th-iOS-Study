//
//  MovieBook.swift
//  MEGABOX
//
//  Created by 정승윤 on 10/7/25.
//

import Foundation
import SwiftUI
import Combine

struct MovieBookView: View {
    @Environment(NavigationRouter.self) var router
    @Environment(MovieViewModel.self) var movieViewModel
    @State private var selectedMovie: MovieModel?
    @State private var isShowingSheet: Bool = false
    @ObservedObject var theaterVM: TheaterViewModel
    
    var body: some View {
        VStack{
            NavigationBar
            
            if let movie = displayMovie {
                MovieNavigationBar( movie: movie, isShowingSheet: $isShowingSheet)
            }// display의 결과값을 movie 로 선언하여 MovieNavigationBar에 사용
            
            MovieList(selectedMovie: $selectedMovie)
                .onChange(of: selectedMovie) { oldValue, newValue in
                    theaterVM.selectedMovie = newValue}
            // 선택된 영화가 바뀔 때마다 onChange 동작
            // theaterVM.selectedMovie 갱신
            // TheaterViewModel의 selectedMovie 변경을 반영
            
            Spacer().frame(height: 32)
            
            TheaterButton(theaterVM: theaterVM)
            // selectedMovie 변경사항을 isEnabled에 반영
            
            Spacer().frame(height: 29)
            
            CalendarView(theaterVM: theaterVM)
            
            Spacer().frame(height:40)
            
            if theaterVM.ShowTheaterInfo {
                TheaterInfoView(theaterVM: theaterVM)
            }
            
            Spacer()
            
        }.padding(.horizontal,16)
        .sheet(isPresented: $isShowingSheet){
                MovieSearchView()
        }
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
        
        private var isSelected: Bool {
            selectedMovie?.id == movie.id
        }
        // 내가 선택한 영화가 맞는지 확인
        
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
                } // 클릭한 영화를 selectedMovie로 설정
            
        }
    }
    
    struct MovieList: View {
        @Environment(MovieViewModel.self) var movieViewModel
        @Binding var selectedMovie: MovieModel?
        var body: some View {
            ScrollView(.horizontal, showsIndicators: false, content: {
                LazyHStack(spacing:8){
                    ForEach(movieViewModel.movies) { movie in MovieCard(selectedMovie: $selectedMovie,movie: movie)}
                }.frame(height: 89)
            }
            )
        }
        
    }
    
    struct TheaterButton: View {
        @ObservedObject var theaterVM: TheaterViewModel
        
        var body: some View {
            HStack{
                ForEach(theaterVM.theaters) {theater in
                    let isSelected = theaterVM.selectedTheater.contains(theater)
                    // 현재 선택된 극장인지 확인
                    Button(role: nil) {
                        theaterVM.selectTheater(theater)
                        // ViewModel에 선택 극장 전달 -> 토글
                    } label: {
                        Text(theater.name)
                            .font(.PretendardsemiBold16)
                            .foregroundStyle(isSelected ? .white : .gray05)
                            .frame(width: 55,height: 35)
                            .background(isSelected ? .purple03 : .gray01)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                    .disabled(!theaterVM.isEnabled)
                    // isEnabled가 false면 버튼 클릭 불가
                }
                Spacer()
            }
        }
    }
   
}


struct MovieBookView_Preview: PreviewProvider {
    static var previews: some View {
        let theaterVM: TheaterViewModel = {
            let vm = TheaterViewModel()
            vm.selectedMovie = MovieModel(posterName: "f1", secPosterName: "", name: "F1 더 무비", engname: "F1 The Movie", performance: "50", age: "12")
            vm.selectedTheater = [TheaterModel(name: "강남")]
            vm.selectedDate = Date()
            return vm
        }()
        
        return devicePreviews {
            MovieBookView(theaterVM: theaterVM)
                .environment(NavigationRouter())
                .environment(MovieViewModel())
                .environmentObject(theaterVM)
        }
    }
}
