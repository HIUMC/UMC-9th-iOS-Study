//
//  HomeView.swift
//  MegaBox
//
//  Created by 이서현 on 9/29/25.
//

import SwiftUI

enum MovieTab: String, CaseIterable {
    case chart = "무비차트"
    case upcoming = "상영예정"
}

struct HomeView: View {
    @Environment(NavigationRouter.self) var router
    @EnvironmentObject var viewModel: MovieViewModel

    
    @State private var tab: MovieTab = .chart

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                TopBarView()
                TopButtonView(select: $tab)
                switch tab {
                case .chart:
                    MovieScrollChart(movies: viewModel.movies) { movie in
                        router.path.append(Route.detail(movie))
                    }
                case .upcoming:
                    EmptyView()
                }
                MovieFeedView().padding(.top, 39)
            }
            .padding(.horizontal, 16)
        }
    }
}
    
    
    //MARK: - 상단 헤더 뷰
    //TODO: - 버튼 클릭 시 색 변화
struct TopBarView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Image(.meboxHeader)
                    .resizable()
                    .frame(width: 149, height: 30)
                    .padding(.bottom, 8)
                Spacer()
            }
            .padding(.bottom, 8)
            HStack(spacing: 0) {
                Button(action: {}) {
                    Text("홈")
                        .foregroundStyle(.gray04)
                        .font(.PretendardSemiBold24)
                }
                Spacer()
                Button(action: {}) {
                    Text("이벤트")
                        .foregroundStyle(.gray04)
                        .font(.PretendardSemiBold24)
                }
                Spacer()
                Button(action: {}) {
                    Text("스토어")
                        .foregroundStyle(.gray04)
                        .font(.PretendardSemiBold24)
                }
                Spacer()
                Button(action: {}) {
                    Text("선호극장")
                        .foregroundStyle(.gray04)
                        .font(.PretendardSemiBold24)
                }
            }
            .padding(.trailing, 70)
        }
        .padding(.bottom, 9)
    }
}
    //MARK: - 상단 버튼 뷰 - 무비차트 | 상영예정
struct TopButtonView: View {
    @Binding var select: MovieTab
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 23) {
                
                ForEach(MovieTab.allCases, id: \.self) {tab in
                    
                    Button (action: { select = tab }) {
                        ZStack {
                            Capsule()
                                .frame(width: 84, height: 38)
                                .glassEffect(.clear.interactive())
                                .foregroundStyle(select == tab ? .gray08 : .gray02)
                            Text(tab.rawValue)
                                .font(.PretendardMedium14)
                                .foregroundStyle(select == tab ? .white : .gray04)
                        }
                    }
                }
                Spacer()
            }
        }
        .padding(.bottom, 25)
        
    }
}
    
//MARK: - 무비 카드 1개
struct MovieCard: View {
    let movieModel: MovieModel
    let onTap: () -> Void
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: onTap) {
                Image(movieModel.poster)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .padding(.bottom, 8)
            }
            
            Button(action: {}) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.purple03)
                        .frame(width: 150, height: 36)
                        .foregroundStyle(.white)
                    Text("바로 예매")
                        .foregroundStyle(.purple03)
                        .font(.PretendardMedium16)
                    
                }
                .padding(.bottom, 8)
            }
            
            Text(movieModel.title)
                .font(.PretendardBold22)
            Text("누적관객수 \(movieModel.countAudience ?? "idk")")
                .font(.PretendardMedium18)
        }
    }
}

//MARK: - 무비차트 가로 스크롤 뷰
struct MovieScrollChart: View {
    let movies: [MovieModel]
    let onSelect: (MovieModel) -> Void
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 24) {
                ForEach(movies) { movie in
                    MovieCard(movieModel: movie) {
                        onSelect(movie)
                    }
                }
            }
        }
        .frame(height: 320)
    }
}

//MARK: - 알고보면 더 재밌는 무비 피드

struct MovieFeedView: View {
    var body: some View {
        VStack(spacing: 0) {
            TopFeedView
            BottomFeedView
        }
    }
    
    
    private var TopFeedView: some View {
        VStack(spacing: 0) {
            HStack {
                Text("알고보면 더 재밌는 무비피드")
                    .font(.PretendardBold24)
                Spacer()
                Button(action: {}) {
                    Image(systemName: "arrow.right.circle")
                        .tint(.gray08)
                        .frame(width: 50, height: 50)
                        .glassEffect(.clear.interactive())
                }
            }
            Image(.movieFeed1)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: .infinity)
                .padding(.bottom, 44)
            
        }
    }
        
    private var BottomFeedView: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(spacing: 0) {
                Image(.movieFeed2)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
                Spacer()
                VStack(alignment: .leading, spacing: 0) {
                    Text("9월, 메가박스의 영화들(1) - 명작들의 재개봉")
                        .font(.PretendardSemiBold18)
                        .foregroundStyle(.black)
                        .padding(.bottom, 25)
                    Text("<모노노케 히메>,<퍼펙트 블루>")
                        .font(.PretendardSemiBold13)
                        .foregroundStyle(.gray03)
                    
                }
            }
            .padding(.bottom, 39)
            
            HStack(spacing: 0) {
                Image(.movieFeed3)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
                Spacer()
                VStack(alignment: .leading, spacing: 0) {
                    Text("메가박스 오리지널 티켓 Re.37 <얼굴>")
                        .font(.PretendardSemiBold18)
                        .foregroundStyle(.black)
                        .padding(.bottom, 25)
                    Text("영화 속 양극적인 감정의 대비")
                        .font(.PretendardSemiBold13)
                        .foregroundStyle(.gray03)
                    
                }
            }
            
            
        }
    }
    
    
    
}


#Preview {
    HomeView()
        .environment(NavigationRouter())
        .environmentObject(MovieViewModel())
}
