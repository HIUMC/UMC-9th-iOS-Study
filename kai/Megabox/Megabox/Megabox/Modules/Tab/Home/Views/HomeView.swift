//
//  HomeView.swift
//  Megabox
//
//  Created by 김지우 on 10/2/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var container: DIContainer

    @State private var viewModel = HomeViewModel()

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                topHeader
                
                if viewModel.selectedHeaderTab == .home {
                    SegmentedTabView(viewModel: viewModel)
                    MovieCardSection(viewModel: viewModel)
                if viewModel.selectedSegment == .chart {  MovieFeedHeader()
                        MovieFeedSection(viewModel: viewModel)
                    }
                } else {
                    Text("\(viewModel.selectedHeaderTab.rawValue) 탭 콘텐츠 준비 중...")
                        .padding(.vertical, 100)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    private var topHeader : some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image("megaboxLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
            
            HStack(spacing: 20) {
                ForEach(HeaderTab.allCases, id: \.self) { tab in
                    Button(action: {
                        viewModel.selectedHeaderTab = tab
                    }) {
                        Text(tab.rawValue)
                            .bold(tab == viewModel.selectedHeaderTab)
                            .foregroundColor(tab == viewModel.selectedHeaderTab ? .black : .gray)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 20)
        }
        .padding(.bottom, 10)
    }
}

// 보조 뷰: 무비차트/상영예정 버튼 섹션
private struct SegmentedTabView: View {
    @Bindable var viewModel: HomeViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(MovieSegment.allCases, id: \.self) { segment in
                Button(action: {
                    viewModel.selectedSegment = segment
                }) {
                    Text(segment.rawValue)
                        .font(.subheadline)
                        .fontWeight(viewModel.selectedSegment == segment ? .bold : .regular)
                        .foregroundColor(viewModel.selectedSegment == segment ? .white : .black)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            Capsule()
                                .fill(viewModel.selectedSegment == segment ? Color.black : Color(uiColor: .systemGray6))
                        )
                }
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 10)
    }
}

// 보조 뷰: 무비카드 가로 스크롤 섹션
private struct MovieCardSection: View {
    @Bindable var viewModel: HomeViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            
            // 상영 예정 빈 화면 처리 로직
            if viewModel.currentMovieList.isEmpty && viewModel.selectedSegment == .upcoming {
                Text("현재 상영 예정인 영화가 없습니다.")
                    .foregroundColor(.gray)
                    .padding(.vertical, 30)
                    .frame(maxWidth: .infinity)
            } else {
                // 무비차트일 때 또는 상영예정인데 데이터가 있을 경우 목록 표시
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 16) {
                        ForEach(viewModel.currentMovieList) { movie in
                            MovieCardView(movie: movie)
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
        .padding(.vertical, 20)
    }
}

// 보조 뷰: 개별 무비 카드 뷰
private struct MovieCardView: View {
    let movie: MovieCardModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Image(movie.imageAssetName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 148, height: 200)
                
            Spacer().frame(height:8)
            Button(action: {
                // 액션
            }) {
                // ⭐️ ZStack을 사용하여 배경 위에 텍스트를 쌓습니다. (버튼의 레이블)
                ZStack {
                    // 1. 배경 (보라색 테두리)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.purple03, lineWidth: 1) // ⭐️ Purple 색상 사용 가정
                        .frame(width: 148, height: 36)
                    
                    // 2. 텍스트
                    Text("바로 예매")
                        .font(.caption) // 텍스트 크기 조정
                        .fontWeight(.bold)
                        .foregroundColor(.purple03)
                }
            }
        
            Spacer().frame(height:5)

            Text(movie.title)
                .font(.subheadline)
                .fontWeight(.bold)
                .lineLimit(2)
            
            Text(movie.audienceCount)
                .font(.caption2)
                .foregroundColor(.gray)
        }
        .frame(width: 140)
    }
}

// 보조 뷰: 무비피드 섹션 제목
private struct MovieFeedHeader: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("알고보면 더 재미있는 무비피드")
                    .font(.headline)
                Spacer()
                Button(action: {
                    /*무비 피드로 연결*/
                }) {
                    Image(systemName: "arrow.right")
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 30)
            .padding(.bottom, 10)
        }
    }
}

// 무비피드 목록 (수직 스택)
private struct MovieFeedSection: View {
    @Bindable var viewModel: HomeViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            Image("hime_banner")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
            
            ForEach(viewModel.movieFeedList) { feed in
                FeedRowView(feed: feed)
            }
        }
        .padding(.bottom, 50)
    }
}

// 보조 뷰: 개별 피드 목록 항목 Row 뷰
private struct FeedRowView: View {
    let feed: MovieFeedModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(feed.imageAssetName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipped()
                .cornerRadius(4)
            
            VStack(alignment: .leading) {
                Text(feed.title)
                    .font(.subheadline)
                    .lineLimit(2)
                
                if let subtitle = feed.subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
                
                if let description = feed.contentDescription {
                     Text(description)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .padding(.top, 4)
                        .lineLimit(1)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    HomeView()
}
