//
//  DetailedMovieCardView.swift
//  UMC_Megabox
//
//  Created by 이한결 on 9/30/25.
//

import SwiftUI
import Kingfisher

struct DetailedMovieCardView: View {
    
    let movieCard: MovieCardDomainModel
    
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
        .navigationTitle(movieCard.movieName)
    }
    
    private var bigPoster: some View {
        // KingFisher를 이용해서 구현
        KFImage(movieCard.bigPoster)
            .resizable()
            .placeholder {
                ProgressView()
            }
            .scaledToFit()
            .frame(height: 248)
    }
    
    private var titles: some View {
        VStack(spacing: 4) {
            Text(movieCard.movieName)
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

/*
#Preview {
    DetailedMovieCardView()
}
*/
