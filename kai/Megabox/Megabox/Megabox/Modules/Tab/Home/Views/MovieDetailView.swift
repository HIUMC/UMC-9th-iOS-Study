//
//  MovieDetailView.swift
//  Megabox
//
//  Created by 김지우 on 10/2/25.
//

import SwiftUI


// MARK: - MovieDetailView: F1 영화 상세 페이지
/*
struct MovieDetailView: View {
    let movie: MovieDetailModel
    
    @State private var selectedSegment: MovieDetailSegment = .detail
    
    @Environment(\.dismiss) var dismiss
    //@Environment(\.safeAreaInsets) private var safeAreaInsets

    var body: some View {
        ZStack(alignment: .top) {
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    
                    // 커스텀 네비게이션 바 높이만큼 Spacer로 밀어내어 내용이 가려지지 않게 함
                    Spacer().frame(height: 44 + safeAreaInsets.top)
                    
                    posterSection
                    textSummarySection
                    detailSegmentTab
                    detailContent
                }
            }
            .ignoresSafeArea(.all, edges: .top)
            
            // 커스텀 내비게이션 바 (ZStack의 top에 고정, 스크롤되지 않음)
            customNavigationBar
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - 섹션별 뷰 정의
    
    private var customNavigationBar: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .padding(10)
                }
                .contentShape(Rectangle())
                
                // 상단 네비게이션바 타이틀
                Text(movie.titleKR)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
            }
            .frame(height: 44)
            .padding(.horizontal, 8)
        }
        .padding(.top, safeAreaInsets.top)
        .background(.ultraThinMaterial)
    }
    
    private var posterSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(movie.detailPosterAssetName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, height: 280)
                .clipped()
        }
    }
    
    private var textSummarySection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(movie.titleKR)
                .font(.title2)
                .bold()
                .foregroundColor(.black)
            Text(movie.titleEN)
                .font(.headline)
                .foregroundColor(.gray)
            
            Text(movie.summary)
                .font(.body)
                .foregroundColor(.secondary)
                .lineSpacing(4)
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }
    
    private var detailSegmentTab: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(MovieDetailSegment.allCases, id: \.self) { segment in
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedSegment = segment
                        }
                    }) {
                        Text(segment.rawValue)
                            .font(.headline)
                            .foregroundColor(selectedSegment == segment ? .black : .gray)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                    }
                }
            }
            
            GeometryReader { geometry in
                Rectangle()
                    .fill(Color.black)
                    .frame(width: geometry.size.width / 2, height: 2)
                    .offset(x: selectedSegment == .review ? geometry.size.width / 2 : 0)
            }
            .frame(height: 2)
            .padding(.bottom, 15)
        }
        .padding(.top, 20)
    }
    
    private var detailContent: some View {
        Group {
            if selectedSegment == .detail {
                DetailContentSection(movie: movie)
            } else {
                ReviewContentSection()
            }
        }
    }
}

// MARK: - 하위 콘텐츠 뷰 (Subviews)

private struct DetailContentSection: View {
    let movie: MovieDetailModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(alignment: .top, spacing: 15) {
                // 직사각형 포스터 썸네일
                Image(movie.detailPosterAssetName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 120)
                    .clipped()
                    .cornerRadius(4)
                
                // 텍스트 정보
                VStack(alignment: .leading, spacing: 5) {
                    Text(movie.rating)
                        .font(.subheadline).bold()
                        .foregroundColor(.black)
                    Text(movie.releaseDate)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding(.top, 10)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 50)
    }
}

private struct ReviewContentSection: View {
    var body: some View {
        VStack {
            Text("등록된 관람평이 없어요")
                .font(.headline)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.purple.opacity(0.5), lineWidth: 1)
        )
        .padding(.horizontal, 16)
        .padding(.bottom, 50)
    }
}

// MARK: - Preview

#Preview {
    let mockMovie = MovieDetailModel(
        titleKR: "F1 더 무비",
        titleEN: "F1: The Movie",
        homePosterAssetName: "f1_square",
        detailPosterAssetName: "f1"
    )
    
    return NavigationStack {
        MovieDetailView(movie: mockMovie)
    }
}
*/
