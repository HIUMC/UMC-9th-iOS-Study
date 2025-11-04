//
//  MovieSheet.swift
//  MegaBox
//
//  Created by 박병선 on 10/9/25.
//
import SwiftUI

struct MovieSheet: View {
    @StateObject var searchVM: MovieSearchViewModel
    let onSelect: (Movie) -> Void

    @Environment(\.dismiss) var dismiss

    private let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 24), count: 3)

    var body: some View {

        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 20) {
                    Text("영화 선택")
                        .font(.title3.bold())
                        .padding(.top, 16)

                    if searchVM.isLoading {
                        ProgressView().padding(.top, 8)
                    }
                    if let error = searchVM.errorMessage { Text(error).foregroundStyle(.red) }

                    // 포스터 그리드
                    LazyVGrid(columns: columns, spacing: 36) {
                        ForEach(movieLineup, id: \.id) { movie in
                            Button {
                                onSelect(movie)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    dismiss()
                                }
                            } label: {
                                VStack(spacing: 8) {
                                    Image(movie.poster)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 95, height: 135)

                                    Text(movie.title)
                                        .font(.pretendardSemiBold(14))
                                        .multilineTextAlignment(.center)
                                        .frame(maxWidth: .infinity)
                                        .foregroundStyle(.black)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 24)

                }
            }

            MovieSearchBar
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
        }
        .ignoresSafeArea(.keyboard)
    }

    /// 검색어가 있으면 결과, 없으면 전체
    private var movieLineup: [Movie] {
        if searchVM.query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return searchVM.movies
        } else {
            return searchVM.results
        }
    }

    /// 하단 검색바
    private var MovieSearchBar: some View {
        Group {
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .frame(width: 26, height: 20)
                TextField("영화명을 입력해주세요", text: $searchVM.query)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                Button { searchVM.query = "" } label: {
                    Image(systemName: "mic")
                        .frame(width: 18, height: 20)
                        .foregroundStyle(.gray05)
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(.ultraThinMaterial)
            .clipShape(Capsule())
        }
    }
}



#Preview {
    MovieSheet(searchVM: MovieSearchViewModel()) { _ in }
}
