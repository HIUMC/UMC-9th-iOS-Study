//
//  SelectMovieView.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/6/25.
//

import SwiftUI

struct SelectMovieView: View {
    
    @ObservedObject var viewModel: BookingViewModel
    @State private var isShowingMovieSearch = false
    
    var body: some View {
        
        VStack(spacing: 19) {
            HStack {
                if let movie = viewModel.selectedMovie {
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: 26, height: 24)
                        .foregroundStyle(.orange)
                        .overlay(Text("\(movie.ageRating)")
                            .foregroundStyle(.white)
                            .font(.PretendardBold(size: 18)))
                }
                
                
                Spacer().frame(width: 37)
                
                Text(viewModel.selectedMovie?.name ?? "영화를 선택하세요.")
                    .font(.PretendardBold(size: 18))
                
                Spacer()
                
                Button( action: { isShowingMovieSearch = true } ) {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.gray02, lineWidth: 1)
                        .foregroundStyle(.clear)
                        .overlay(Text("전체영화")
                            .foregroundStyle(.black)
                            .font(.PretendardSemiBold(size: 14)))
                        .frame(width: 69, height: 30)
                }
                
            }.frame(height: 30)
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 8) {
                    ForEach(viewModel.allMovies) { movie in
                        Button( action: { viewModel.selectedMovie = movie } ) {
                            Image(movie.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 62, height: 89)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke( viewModel.selectedMovie == movie ? .purple03 : Color.clear, lineWidth: 2)
                            
                        }
                    }
                }
            }
            
        }.frame(height: 139)// end of VStack
            .sheet(isPresented: $isShowingMovieSearch) {
                        // isShowingMovieSearch가 true가 되면 이 뷰를 시트로 띄움
                        // BookingViewModel의 selectedMovie를 Binding으로 전달
                        MovieSearchView(selectedMovie: $viewModel.selectedMovie)
                    }
    }
}

#Preview {
    SelectMovieView(viewModel: BookingViewModel())
}
