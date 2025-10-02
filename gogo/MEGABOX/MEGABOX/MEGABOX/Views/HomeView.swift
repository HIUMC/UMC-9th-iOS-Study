//
//  HomeView.swift
//  MEGABOX
//
//  Created by 고석현 on 10/2/25.
//

import SwiftUI


//MARK: -무비차트/상영예정 탭
enum MovieTab: String, CaseIterable {
    case chart = "무비차트"
    case upcoming = "상영예정"
}

struct HomeView: View {
    @Environment(NavigationRouter.self) var router
    @Environment(MovieViewModel.self) var viewModel
    
    @State private var selectedTab: String = "홈"
    @State private var tab: MovieTab = .chart
    
    var body: some View {
        VStack {
            TopBarView(selectedTab: $selectedTab)
            Group {
                switch selectedTab {
                case "홈":
                    homeMainView
                default:
                    EmptyView()
                }
            }
        }
    }
}

private extension HomeView {
    var homeMainView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            TopButtonView(select: $tab)
            switch tab {
            case .chart:
                MovieFeedView(movies: viewModel.movies, onSelect: {movie in
                    router.push(.movieDetail(movie: movie))
                })
            case .upcoming:
                EmptyView()
            }
        }
    }
}

//MARK: - 상단바 뷰
struct TopBarView: View {
    @Binding var selectedTab: String
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Spacer().frame(width: 20)
                Image(.meboxLogo)
                    .resizable()
                    .frame(width: 149, height: 30)
                    .padding(.bottom, 8)
                Spacer()
            }
            .padding(.bottom, 8)
            HStack(spacing: 0) {
                Spacer().frame(width: 20)
                Button(action: { selectedTab = "홈" }) {
                    Text("홈")
                        .foregroundStyle(selectedTab == "홈" ? .black : .gray04)
                        .font(.PretendardSemiBold(size:24))
                }
                Spacer()
                Button(action: { selectedTab = "이벤트" }) {
                    Text("이벤트")
                        .foregroundStyle(selectedTab == "이벤트" ? .black : .gray04)
                        .font(.PretendardSemiBold(size:24))
                }
                Spacer()
                Button(action: { selectedTab = "스토어" }) {
                    Text("스토어")
                        .foregroundStyle(selectedTab == "스토어" ? .black : .gray04)
                        .font(.PretendardSemiBold(size:24))
                }
                Spacer()
                Button(action: { selectedTab = "선호극장" }) {
                    Text("선호극장")
                        .foregroundStyle(selectedTab == "선호극장" ? .black : .gray04)
                        .font(.PretendardSemiBold(size:24))
                }
            }
            .padding(.trailing, 70)
        }
        .padding(.bottom, 9)
    }
}

//MARK: - 무비 카드 (하위 블럭)
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
                        .font(.PretendardMedium(size:16))

                }
                .padding(.bottom, 8)
            }

            Text(movieModel.title)
                .font(.PretendardBold(size:22))
            Text("누적관객수 \(movieModel.countAudience)")
                .font(.PretendardMedium(size:18))
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

//MARK: - TopButtonView
struct TopButtonView: View {
    @Binding var select: MovieTab
    var body: some View {
        HStack(spacing: 0) {
            Spacer().frame(width: 20)
            ForEach(MovieTab.allCases, id: \.self) { tab in
                Button {
                    select = tab
                } label: {
                    Text(tab.rawValue)
                        .foregroundStyle(select == tab ? .black : .gray04)
                        .font(.PretendardSemiBold(size: 24))
                }
                Spacer()
            }
        }
        .padding(.bottom, 16)
    }
}

//MARK: - MovieFeedView
struct MovieFeedView: View {
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
            .padding(.horizontal, 20)
        }
        .frame(height: 320)
    }
}


#Preview {
    HomeView()
        .environment(NavigationRouter())
        .environment(MovieViewModel())
}

