//
//  MovieinfoView.swift
//  week1_homework
//
//  Created by 정승윤 on 10/1/25.
//

import Foundation
import SwiftUI
import Kingfisher

// 패스뷰를 통해서 들어오면 패딩이 적용이 안됌
// NavigationStack -> 자식 뷰로 갈때 레이아웃이 달라지기 때문
// 패스 뷰로 들어왔을 때 레이아웃 깨지는걸 어떻게 해야 할지 모르겠음.,
struct MovieInfoView: View {

    let movie: MovieCardModel
    @Environment(TMDBViewModel.self) var tmdbviewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
        NavigationBar
        ScrollView {
                MovieInfo
                Spacer().frame(height: 35)
                MovieDetailBar
                Spacer().frame(height: 17)
                MovieDetail
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal,16)
        }.navigationBarBackButtonHidden(true)
    }
    // NavigationBar를 빼주니까 해결.
    // 아니면 하드코딩된 넓이를 수정해줘서 해결된건가?
    private var NavigationBar: some View {
        VStack{
            HStack{
                Button(action: {dismiss()
                }){Text(Image(systemName: "arrow.left")).foregroundStyle(.black)}
                    
                Spacer()
                
                Text(movie.title)
                        .font(.Pretendardmedium18)
                        .padding(.trailing,162)
                
            }.frame(maxWidth: .infinity)
           
        }.padding(.horizontal,16)
        
        }
    
    private var MovieInfo: some View {
        // 로컬 변수 쓰니 뭘 반환할지 헷갈려함 -> return으로 명시
        VStack(alignment: .center){
            KFImage(URL(string: movie.backdropURL))
                        .placeholder { ProgressView() }
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight:248)
            Spacer().frame(height: 9)
            Text(movie.title).font(.PretendardBold24)
            Text(movie.title).foregroundStyle(.gray03).font(.PretendardsemiBold14)
            Text(movie.overview)
                        .font(.PretendardsemiBold18)
                        .foregroundStyle(.gray03)
                        .frame(maxWidth: .infinity, alignment: .leading)
        }.onAppear {
            Task{
                await tmdbviewModel.fetchNowPlayingMovies()
            }
        }
    }
    
    private var MovieDetailBar: some View {
        HStack{
            VStack{
                Text("상세정보").font(.PretendardBold22)
                Rectangle()
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
            }
            
            VStack{
                Text("실관람평").font(.PretendardBold22)
                Rectangle().frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
            }   
        }
    }
    
    private var MovieDetail: some View {
        return HStack{
            KFImage(URL(string: movie.posterURL))
                        .resizable()
                        .frame(width: 100,height: 120)
            VStack{
                Text(movie.rating).font(.PretendardsemiBold13)
                Spacer().frame(height:9)
                Text("\(movie.releaseDate) 개봉").font(.PretendardsemiBold13)
            }
            Spacer()
        }
    }
}

struct MovieInfoView_Preview: PreviewProvider {
    static var tmdbViewModel = TMDBViewModel()
    static var previews: some View {
        devicePreviews {
            MovieInfoView(movie: MovieCardModel(
                id: 1,
                title: "영화 제목 (API)",
                posterURL: "https://image.tmdb.org/t/p/w500/sample_path.jpg", // 실제 이미지 URL로 대체
                originalTitle: "영화 제목 (영)",
                backdropURL: "https://image.tmdb.org/t/p/w500/sample_path.jpg",
                overview: "개요",
                releaseDate: "2025-10-22",
                rating: "3.0",
                attendance: "100만명"
            ))
                .environment(NavigationRouter())
                .environment(tmdbViewModel)
        }
    }
}
