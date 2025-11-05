//
//  HomeView.swift
//  MEGABOX
//
//  Created by 박정환 on 10/1/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(MovieViewModel.self) private var viewModel
    @Environment(NavigationRouter.self) private var router
    
    @State private var selected: ChartTab = .chart
    private enum ChartTab { case chart, upcoming }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HeaderSection
                MovieChartSection
                MovieFeedSection
            }
        }
    }
    
    private var HeaderSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(.meboxTitle)
            HStack(spacing: 16) {
                Text("홈")
                Text("이벤트")
                Text("스토어")
                Text("선호극장")
            }
            .font(.headline)
        }
        .padding(.top, 23)
        .padding(.horizontal, 16)
        
    }
    
    private var MovieChartSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 23) {
                Button {
                    withAnimation(.easeInOut) { selected = .chart }
                } label: {
                    Text("무비차트")
                        .font(.medium14)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 10)
                        .background(
                            Capsule()
                                .fill(selected == .chart ? Color.gray08 : Color.gray02)
                        )
                        .foregroundColor(selected == .chart ? .white : .gray04)
                }
                
                Button {
                    withAnimation(.easeInOut) { selected = .upcoming }
                } label: {
                    Text("상영예정")
                        .font(.medium14)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 10)
                        .background(
                            Capsule()
                                .fill(selected == .upcoming ? Color.gray08 : Color.gray02)
                        )
                        .foregroundColor(selected == .upcoming ? .white : .gray04)
                }
                Spacer()
            }
            
            if selected == .chart {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 24) {
                        ForEach(viewModel.movies) { movie in
                            VStack(alignment: .leading) {
                                if movie.poster == "poster3" {
                                    Button {
                                        router.push(.detail(movie))
                                    } label: {
                                        Image(movie.poster)
                                            .resizable()
                                            .scaledToFit()
                                    }
                                } else {
                                    Image(movie.poster)
                                        .resizable()
                                        .scaledToFit()
                                }
                                
                                Button(action: {}) {
                                    Text("바로 예매")
                                        .font(.medium16)
                                        .foregroundColor(Color.purple03)
                                        .frame(width: 148, height: 36)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.purple03, lineWidth: 1)
                                        )
                                }
                                Text(movie.title)
                                    .font(.bold22)
                                    .lineLimit(1)
                                    .padding(.bottom, 3)
                                
                                Text("누적관객수 \(movie.countAudience ?? "")")
                                    .font(.medium18)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
            } else {
                
            }
        }
        .padding(.leading, 16)
    }
    
    
    private var MovieFeedSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center) {
                Text("알고보면 더 재밌는 무비피드")
                    .font(.bold24)
                Spacer()
                Image(systemName: "arrow.right.circle")
                    .tint(.gray08)
                    .frame(width: 39, height: 39)
            }
            
            Image(.feed1)
                .resizable()
                .scaledToFit()
                .padding(.bottom,44)
            
            VStack(spacing: 40) {
                HStack(alignment: .top) {
                    Image(.feed2)
                    
                    VStack(alignment: .leading) {
                        Text("9월, 메가박스의 영화들(1) - 명작들의 재개봉")
                            .font(.semiBold18)
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Text("<모노노케 히메>, <퍼펙트 블루>")
                            .font(.semiBold13)
                            .foregroundColor(.gray03)
                    }
                    Spacer()
                }
                
                HStack(alignment: .top, spacing: 0) {
                    Image(.feed3)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("메가박스 오리지널 티켓 Re.37 <얼굴>")
                            .font(.semiBold18)
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Text("영화 속 양극적인 감정의 대비")
                            .font(.semiBold13)
                            .foregroundColor(.gray03)
                    }
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

    
#Preview {
    NavigationStack {
        HomeView()
    }
    .environment(NavigationRouter())
    .environment(MovieViewModel())
}
