//
//  HomeView.swift
//  MEGABOX
//
//  Created by 고석현 on 10/2/25.
//

import SwiftUI




struct HomeView: View {
    @Environment(NavigationRouter.self) var router
    @EnvironmentObject var viewModel: MovieViewModel
    
    @State private var selectedTab: String = "홈"
    @State private var tab: MovieTab = .chart
    
    var body: some View {
        VStack {
            TopBarView(selectedTab: $selectedTab)
            Group {
                switch selectedTab {
                case "홈":
                    homeMainView
                case "이벤트":
                    VStack {
                        Text("이벤트 뷰 작성 예정")
                        Spacer()
                    }
                case "스토어":
                    VStack {
                        Text("스토어 뷰 작성 예정")
                        Spacer()
                    }
                case "선호극장":
                    VStack {
                        Text("선호극장 뷰 작성 예정")
                        Spacer()
                    }
                default:
                    EmptyView()
                }
            }
        }
       
    }
}

//MARK: - 홈 메인 뷰 extension으로 처리 ("홈" 눌렀을때만 나오도록)
private extension HomeView {
    var homeMainView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            TopButtonView(select: $tab)
            switch tab {
            case .chart:
                MovieScrollView(movies: viewModel.movies, onSelect: {movie in
                    router.push(.movieDetail(movie: movie))
                })
            case .upcoming:
                Text("상영예정 하위뷰 작성 예정!!!!!!")
                    .font(.PretendardBold(size: 20))
                //TODO: - 상영예정 하위뷰
            
            }
            TopFeedView
            BottomFeedView
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



//MARK: -무비차트/상영예정 탭 Enum
enum MovieTab: String, CaseIterable {
    case chart = "무비차트"
    case upcoming = "상영예정"
}

//MARK: - 무비차트/상영예정
struct TopButtonView: View {
    @Binding var select: MovieTab
    var body: some View {
        HStack(spacing: 10) {
            ForEach(MovieTab.allCases, id: \.self) { tab in
                Button {
                    select = tab
                } label: {
                    Text(tab.rawValue)
                        .font(.PretendardMedium(size: 14))
                        .frame(width: 84, height: 38, alignment: .center)
                        .background(
                            Capsule()
                                .fill(select == tab ? Color.gray08 : Color.gray02)
                        )
                        .foregroundStyle(select == tab ? .white : .gray04)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.vertical, 6)
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
            Spacer().frame(height: 4)

            Text(movieModel.title)
                .font(.PretendardBold(size:22))
            Spacer().frame(height: 2)
            Text("누적관객수 \(movieModel.countAudience)")
                .font(.PretendardMedium(size:18))
        }
    }
}

//MARK: - 무비차트 가로 스크롤뷰
struct MovieScrollView: View {
    let movies: [MovieModel]
    let onSelect: (MovieModel) -> Void
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
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


//MARK: -알고보면 더 재밌는 무비피드
private var TopFeedView: some View {
    VStack(spacing: 0) {
        HStack {
            Text("알고보면 더 재밌는 무비피드")
                .font(.PretendardBold(size:24))
            Spacer()
            Button(action: {
                //TODO: -"알고보면 더 재밌는 무비 피드" 이동
            }) {
                Image("right")
                    .tint(.gray08)
                    .frame(width: 50, height: 50)
//                    .glassEffect(.clear.interactive())
            }
        }
        Image(.movieFeed1)
            .resizable()
            .aspectRatio(contentMode: .fit)
//            .frame(width: .infinity)
            .padding(.bottom, 25)
    }
    .padding(.horizontal, 20)
    
}

//MARK: -하단 영화 피드
private var BottomFeedView: some View {
    VStack(alignment: .leading, spacing: 0) {
        HStack(spacing: 12) {
            Image(.movieFeed2)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
            VStack(alignment: .leading, spacing: 0) {
                Text("9월, 메가박스의 영화들(1) - 명작들의 재개봉")
                    .font(.PretendardSemiBold(size:18))
                    .foregroundStyle(.black)
                    .padding(.bottom, 25)
                Text("<모노노케 히메>,<퍼펙트 블루>")
                    .font(.PretendardSemiBold(size:13))
                    .foregroundStyle(.gray03)
            }
        }
//        .padding(.horizontal, 20)
        .padding(.bottom, 39)

        HStack(spacing: 12) {
            Image(.movieFeed3)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
            VStack(alignment: .leading, spacing: 0) {
                Text("메가박스 오리지널 티켓 Re.37 <얼굴>")
                    .font(.PretendardSemiBold(size:18))
                    .foregroundStyle(.black)
                    .padding(.bottom, 25)
                Text("영화 속 양극적인 감정의 대비")
                    .font(.PretendardSemiBold(size:13))
                    .foregroundStyle(.gray03)
            }
        }
//        .padding(.horizontal, 20)
    }
    .padding(.horizontal, 20)
 
}





#Preview {
    HomeView()
        .environment(NavigationRouter())
        .environmentObject(MovieViewModel())
}
