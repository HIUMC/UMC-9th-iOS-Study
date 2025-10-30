//
//  DetailedMovieCardView.swift
//  UMC_Megabox
//
//  Created by 이한결 on 9/30/25.
//

import SwiftUI

struct DetailedMovieCardView: View {
    
    /*
     부모 뷰의 ForEach 루프 내에서 데이터를 받아서 쓰기만 하므로
     초기화 해줄필요도, @State변수로 선언해줄 필요도 없음
     */
    let movieCard: MovieCard
    
    var body: some View {
        ScrollView {
            VStack {
                bigPoster
                Spacer().frame(height: 9)
                titles
                Spacer().frame(height: 9)
                explain.padding(.horizontal)
                Spacer().frame(height: 30)
                btns
                Spacer().frame(height: 15)
                bottomView.padding(.horizontal)
                Spacer()
            }
        }
        .navigationTitle(movieCard.MovieName)
    }
    
    private var bigPoster: some View {
        Image(movieCard.bigPoster)
            .resizable()
            .scaledToFit()
            .frame(height: 248)
    }
    
    private var titles: some View {
        VStack(spacing: 4) {
            Text(movieCard.MovieName)
                .font(.PretendardBold(size: 24))
                .foregroundStyle(.black)
            Text(movieCard.subTitle)
                .font(.PretendardSemiBold(size: 14))
                .foregroundStyle(.gray03)
        }
    }
    
    private var explain: some View {
        Text(movieCard.explaination)
            .font(.PretendardSemiBold(size: 18))
            .foregroundStyle(.gray03)
            .frame(height: 175)
    }
    
    private var btns: some View {
        HStack(spacing: 0) {
            Button(action: { } ) {
                VStack {
                    Text("상세 정보")
                        .font(.PretendardBold(size: 22))
                        .foregroundStyle(.black)
                        .frame(width: 220, height: 30, alignment: .center)
                    
                    Rectangle()
                        .foregroundStyle(.black)
                        .frame(width: 220, height: 2)
                        
                }.frame(height: 34.99984)
            }
            
            Button(action: { } ) {
                VStack {
                    Text("실관람평")
                        .font(.PretendardBold(size: 22))
                        .foregroundStyle(.gray02)
                        .frame(width: 220, height: 30, alignment: .center)
                    
                    Rectangle()
                        .foregroundStyle(.gray02)
                        .frame(width: 220, height: 2)
                }.frame(height: 34.99984)
            }
        }
    }
    
    private var bottomView: some View {
        HStack {
            
            Image(movieCard.smallPoster)
                .frame(height: 120)
            
            VStack {
                Text(movieCard.age)
                    .font(.PretendardSemiBold(size: 13))
                    .foregroundStyle(.black)
                    .frame(height: 18)
                
                Spacer().frame(height: 9)
                
                Text(movieCard.date)
                    .font(.PretendardSemiBold(size: 13))
                    .foregroundStyle(.black)
                    .frame(height: 18)
                
                Spacer()
            }.frame(height: 120)
            
            
            Spacer()
        }.frame(height: 120)
        
        
    }
    
}


#Preview {
    DetailedMovieCardView(movieCard:
    MovieCard(MoviePoster: "poster_f1",
              MovieName: "F1 더 무비",
              People: "100만",
              bigPoster: "poster_f1_big",
              subTitle: "F1: The Movie",
              explaination:"최고가 되지 못한 전설 VS 최고가 되고 싶은 루키\n\n한때 주목받는 유망주였지만 끔찍한 사고로 F1에서  우승하지 못하고\n한순간에 추락한 드라이버 ‘손; 헤이스'(브래드 피트).\n그의 오랜 동료인 ‘루벤 세르반테스'(하비에르 바르뎀)에게\n레이싱 복귀를 제안받으며 최하위 팀인 APGXP에 합류한다." ,
              smallPoster: "poster_f1_small",
              age: "12세 이상 관람가",
              date: "2025.06,25 개봉"))
}
