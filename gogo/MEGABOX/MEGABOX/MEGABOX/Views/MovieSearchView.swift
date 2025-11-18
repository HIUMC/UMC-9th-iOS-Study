//
//  MovieSearchView.swift
//  MEGABOX
//
//  Created by 고석현 on 10/9/25.
//

//
//  MovieSearchView.swift
//  MEGABOX
//
//  Created by 고석현 on 10/10/25.
//

import SwiftUI

// MARK: - 영화 검색 뷰
// 사용자가 영화명을 입력하면 MovieSearchViewModel을 통해 검색 결과를 표시함
struct MovieSearchView: View {
    
    // MARK: - 상태 관리
    @StateObject private var viewModel = MovieSearchViewModel() // 뷰모델 연결
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                searchBarSection      // 상단 검색창
                statusIndicatorSection // 로딩/에러 표시
                
                resultListSection      // 검색 결과 리스트
            }
            .padding(.horizontal, 16)
            .navigationTitle("영화 검색")
        }
    }
}

// MARK: - 검색창 영역
private extension MovieSearchView {
    var searchBarSection: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.primary)
            
            // 텍스트 입력창
            TextField("영화명을 입력해주세요", text: $viewModel.query)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            
            Image(systemName: "mic")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(Color.black.opacity(0.06), lineWidth: 0.5)
        )
    }
}

// MARK: - 로딩/에러 상태
private extension MovieSearchView {
    var statusIndicatorSection: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("검색 중...")
                    .padding(.top, 8)
            }
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .font(.subheadline)
                    .foregroundStyle(.red)
                    .padding(.top, 4)
            }
        }
    }
}

// MARK: - 검색 결과 리스트
private extension MovieSearchView {
    var resultListSection: some View {
        // 검색어가 없을 땐 빈 뷰, 있으면 결과 표시
        Group {
            if viewModel.results.isEmpty && !viewModel.query.isEmpty && !viewModel.isLoading {
                Text("검색 결과가 없습니다")
                    .font(.PretendardSemiBold(size:16))
                    .foregroundStyle(.gray04)
                    .padding(.top, 40)
            } else if !viewModel.results.isEmpty {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 12) {
                        ForEach(viewModel.results, id: \.id) { movie in
                            MovieResultCell(movie: movie)
                                .onTapGesture {
                                    viewModel.selectedMovie = movie
                                }
                                .padding(.horizontal, 4)
                        }
                    }
                    .padding(.top, 8)
                }
            } else {
                EmptyView()
            }
        }
    }
}

// MARK: - 개별 영화 셀
private struct MovieResultCell: View {
    let movie: MovieModel
    
    var body: some View {
        HStack(spacing: 12) {
            Image(movie.poster)
                .resizable()
                .scaledToFill()
                .frame(width: 95, height: 135)
                .clipped()
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .font(.PretendardBold(size:18))
                    .foregroundStyle(.black)
                    .lineLimit(2)
                
                if let date = movie.releaseDate {
                    Text(date)
                        .font(.PretendardSemiBold(size:14))
                        .foregroundStyle(.gray05)
                }
                
                if let rating = movie.rating {
                    Text(rating)
                        .font(.PretendardSemiBold(size:14))
                        .foregroundStyle(.gray04)
                }
                
                if let audience = movie.countAudience {
                    Text("관객수 \(audience)")
                        .font(.PretendardSemiBold(size:14))
                        .foregroundStyle(.gray03)
                }
            }
            Spacer()
        }
        .padding(.vertical, 6)
    }
}

// MARK: - 프리뷰
#Preview {
    MovieSearchView()
}
