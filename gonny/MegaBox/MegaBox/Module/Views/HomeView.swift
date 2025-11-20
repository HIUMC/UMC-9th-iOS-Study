//
//  HomeView.swift
//  MegaBox
//
//  Created by 박병선 on 9/30/25.
//
import SwiftUI
import Kingfisher

struct HomeView: View {
    @Environment(NavigationRouter.self) var router
    @StateObject var viewModel: HomeViewModel
    @StateObject var vm: MovieViewModel
    
    var body: some View {
        @Bindable var router = router
        
        NavigationStack(path: $router.path) {
            VStack(spacing: 10) {
                // 상단 탭바
                TopTabBar()
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        
                        // 카테고리 버튼(무비차트/상영예정)
                        CategorySelector()
                            .padding(.horizontal, 16)
                        
                        // 영화 포스터 가로 스크롤
                        PosterScrollSection(viewModel: viewModel)
                        
                        // 무비피드
                        MovieFeedSection()
                        
                        PromotionSection()
                    }
                    .padding(.vertical, 12)
                }
                .background(Color.white)
            }
            
            if vm.isLoading {
                Color.black.opacity(0.2)
                    .ignoresSafeArea()
                ProgressView("영화 불러오는 중...")
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
            }
        }
            //  navigationDestination을 MovieDetail 타입으로 연결
            .navigationDestination(for: MovieDetail.self) { detail in
                MovieDetailView(movieDetail: detail)
            }
        // 화면이 나타날 때 TMDB API 한 번 호출
            .task {
                await vm.loadNowPlaying()
            }
        }
       
    }

// MARK: - 상단 탭바
struct TopTabBar: View {
    let tabs = ["홈", "이벤트", "스토어", "선호극장"]
    @State private var selected = "홈"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image("megabox_logo")
                .resizable()
                .frame(width: 149, height: 30)
                .padding(.leading)
                .padding(.top)
            
            HStack(spacing: 24) {
                ForEach(tabs, id: \.self) { tab in
                    Text(tab)
                        .font(.pretendardSemiBold(24))
                        .foregroundStyle(selected == tab ? .black00 : .gray06)
                        .onTapGesture { selected = tab }
                }
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
        }
    }
}

// MARK: - 카테고리 선택
struct CategorySelector: View {
    @State private var selected = "무비차트"
    let categories = ["무비차트", "상영예정"]
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(categories, id: \.self) { category in
                Text(category)
                    .font(.pretendardMedium(14))
                    .foregroundStyle(
                        selected == category ? Color("white00") : Color("gray04")
                    )
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background {
                        if selected == category {
                            Capsule().fill(Color("gray08"))
                        } else {
                            Capsule().fill(Color("gray02"))
                        }
                    }
                    .onTapGesture { selected = category }
            }
        }
    }
}

// MARK: - 포스터 스크롤 섹션
struct PosterScrollSection: View {
    @Environment(NavigationRouter.self) var router
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.movies) { movie in
                        PosterCard(movie: movie, viewModel: viewModel)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

// MARK: - 포스터 카드
private struct PosterCard: View {
    @Environment(NavigationRouter.self) var router
    let movie: Movie
    let viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            //  포스터 클릭 → TMDB에서 매핑된 MovieDetailView로 이동
            Button {
                /* API 연결 전 코드 */
                /*
                 if let detail = viewModel.movieDetails.first(where: { $0.titleKR == movie.title }) {
                    router.push(detail)  //  단순히 detail을 path에 추가
                }
                 */
                if let detail = viewModel.detail(for: movie) {
                    router.push(detail)
                }
            }
            /*
             API 연결 전
             label: {
                Image(movie.poster)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 140, height: 200)
                    .cornerRadius(8)
                    .padding(.bottom, 5)
            }
*/
            label: {
                            KFImage(URL(string: movie.poster))
                                .placeholder {                      // 이이미지 로딩 중
                                    ZStack {
                                        Rectangle()
                                            .fill(Color("gray02"))
                                            .frame(width: 140, height: 200)
                                            .cornerRadius(8)
                                        ProgressView()
                                    }
                                }
                                .retry(maxCount: 2, interval: .seconds(1))
                                .cancelOnDisappear(true)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 140, height: 200)
                                .cornerRadius(8)
                                .clipped()
                                .padding(.bottom, 5)
                        }
            // 바로 예매 버튼
            Button(action: {}) {
                Text("바로 예매")
                    .font(.pretendardMedium(16))
                    .foregroundStyle(.purple03)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.purple03, lineWidth: 1)
                            .frame(width: 140, height: 36)
                    )
            }

            VStack(alignment: .leading, spacing: 5) {
                Text(movie.title)
                    .font(.pretendardBold(22))
                    .foregroundStyle(.black00)
                
                Text(movie.audience ?? "정보 없음")
                    .font(.pretendardMedium(18))
                    .foregroundStyle(.black00)
            }
        }
    }
}

// MARK: - 피드 섹션
struct MovieFeedSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("알고보면 더 재밌는 무비피드")
                    .font(.pretendardBold(24))
                    .foregroundStyle(.black00)
                
                Spacer()
                Button(action: {}) {
                    Image(systemName: "arrow.right")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.black00)
                }
            }
            .padding(.horizontal)
            
            Image("mono_asitaka")
                .resizable()
                .frame(width: 380, height: 220)
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

// MARK: - 광고 프로모션 섹션
struct FeedRow: View {
    let item: AdItem
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(item.imageName)
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(width: 92, height: 92)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            VStack(alignment: .leading, spacing: 8) {
                Text(item.title)
                    .font(.pretendardSemiBold(18))
                    .foregroundStyle(.black00)
                    .lineLimit(2)
                if let sub = item.subtitle, !sub.isEmpty {
                    Text(sub)
                        .font(.pretendardMedium(13))
                        .foregroundStyle(.gray03)
                }
            }
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 12)
    }
}

struct PromotionSection: View {
    @StateObject private var vm = AdViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(vm.items) { item in
                FeedRow(item: item)
                Divider()
                    .padding(.leading, 18 + 92 + 16)
            }
        }
        .background(Color(.systemBackground))
    }
}

/*
#Preview {
    HomeView(viewModel: HomeViewModel(), vm: MovieViewModel())
        .environment(NavigationRouter()) //  최신 방식 프리뷰 주입
}
*/
