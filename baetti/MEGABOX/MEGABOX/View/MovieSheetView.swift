//
//  MovieSheetView.swift
//  MEGABOX
//
//  Created by 박정환 on 10/8/25.
//

import SwiftUI

struct MovieSheetView: View {
    @ObservedObject var viewModel: MovieSheetViewModel
    
    // 3열 그리드
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 16), count: 3)
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            // 타이틀
            Text("영화 선택")
                .font(.semiBold18)
                .padding(.top, 8)
            
            // 검색창
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("영화명을 입력해주세요", text: $viewModel.query)
                    .textFieldStyle(PlainTextFieldStyle())
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))
            
            // 영화 목록
            ScrollView {
                VStack(spacing: 36) {
                    if viewModel.isLoading {
                        ProgressView()
                    }
                    if let msg = viewModel.errorMessage {
                        Text(msg)
                            .font(.footnote)
                            .foregroundColor(.red)
                    }
                    LazyVGrid(columns: columns, spacing: 20) {

                        ForEach(Array(displayedMovies.enumerated()), id: \.offset) { idx, movie in
                            Button {
                                viewModel.select(movie: movie)
                            } label: {
                                VStack(spacing: 8) {
                                    posterView(named: movie.poster)
                                        .frame(width: 95, height: 135)

                                    Text(movie.title)
                                        .font(.semiBold14)
                                        .multilineTextAlignment(.center)
                                        .foregroundStyle(Color(.black))
                                }
                            }
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .padding(.horizontal, 16)
    }
    
    // 검색 결과 표시용 소스 (쿼리 없으면 전체, 있으면 결과)
    private var displayedMovies: [MovieModel] {
        viewModel.query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? viewModel.movies : viewModel.results
    }
    
    // 기존 posterView를 그대로 재사용할 수 있게 별도 함수 제공
    private func posterView(named name: String) -> some View {
        Image(name)
            .resizable()
            .scaledToFill()
    }
}

#Preview {
    MovieSheetView(viewModel: MovieSheetViewModel())
}
