//
//  MovieDetailView.swift
//  MegaBox
//
//  Created by 이서현 on 9/29/25.
//

import SwiftUI

struct MovieDetailView: View {
    @State private var selectedTab: Int = 0
    @Environment(\.dismiss) private var dismiss
    
    let movie: MovieModel
    var body: some View {
        VStack(spacing: 0) {
            TopBarView
            ContentView
            MovieDetailViewCard(selectedTab: $selectedTab)
            if selectedTab == 0 {
                CardView
            } else {
                EmptyView()
            }
            Spacer()
        }
        .padding(.horizontal, 16)
    }
    
    private var TopBarView: some View {
        HStack{
            Button(action: { dismiss() }) {
                Image(systemName: "arrow.left.circle")
                    .frame(width: 50, height: 50)
                    .tint(.gray03)
                    .glassEffect(.clear.interactive())
            }
            Spacer()
            Text(movie.title)
                .padding(.trailing, 45)
            Spacer()
        }
    }
    
    //MARK: - ContentView
    
    private var ContentView: some View {
        VStack(alignment: .center, spacing: 0) {
            Image(.topF1)
                .resizable()
                .frame(maxWidth: .infinity)
                .scaledToFit()
                .padding(.bottom, 13)
            Text(movie.title)
                .font(.PretendardBold24)
                .foregroundStyle(.black)
                .padding(.bottom, 3)
            Text("F1 : The Movie") // MovieModel 에 영어이름 속성을 추가해야 하는 건지?
                .font(.PretendardSemiBold14)
                .foregroundStyle(.gray03)
                .padding(.bottom, 9)
            Text("""
                최고가 되지 못한 전설 VS 최고가 되고 싶은 루키

                한때 주목받는 유망주였지만 끔찍한 사고로 F1에서  우승하지 못하고
                한순간에 추락한 드라이버 ‘손; 헤이스'(브래드 피트).
                그의 오랜 동료인 ‘루벤 세르반테스'(하비에르 바르뎀)에게
                레이싱 복귀를 제안받으며 최하위 팀인 APGXP에 합류한다.
                """)
            .font(.PretendardSemiBold18)
            .foregroundStyle(.gray03)
            .padding(.bottom, 25)
        }
    }
    
    
    private var CardView: some View {
        HStack(spacing: 0) {
            Image(.posterF1)
                .resizable()
                .scaledToFit()
                .frame(width: 100)
            
            VStack(alignment: .center, spacing: 7) {
                Group {
                    Text("12세 이상 관람가")
                    Text("2025.06.25 개봉")
                }
                .font(.PretendardSemiBold13)
                .foregroundStyle(.black)
            }
            .padding(.horizontal, 26)
            Spacer()
        }
    }
    
}

//MARK: - 상세정보 뷰
struct MovieDetailViewCard: View {
    @Binding var selectedTab: Int
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<2) { index in
                let title = index == 0 ? "상세 정보" : "실관람평"
                Button(action: {
                    withAnimation(.easeInOut) {
                        selectedTab = index
                    }
                }) {
                    VStack(spacing: 2) {
                        if selectedTab == index {
                            Text(title)
                                .font(.PretendardBold22)
                                .foregroundStyle(.black)
                            Rectangle()
                                .frame(maxWidth: .infinity)
                                .frame(height: 1)
                                .foregroundStyle(.black)
                            
                        } else {
                            Text(title)
                                .font(.PretendardBold22)
                                .foregroundStyle(.gray02)
                            Rectangle()
                                .frame(maxWidth: .infinity)
                                .frame(height: 1)
                                .foregroundStyle(.gray02)
                        }
                    }
                    .padding(.bottom, 13) // 피그마 줄자 이슈..
                }
            }
        }
    }
}




#Preview {
    MovieDetailView(movie: MovieModel(title: "어쩔 수가 없다", poster: "poster1", countAudience: "20만"))
}
