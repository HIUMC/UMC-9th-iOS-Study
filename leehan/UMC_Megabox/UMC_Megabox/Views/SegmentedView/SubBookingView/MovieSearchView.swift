//
//  MovieSearchView.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/7/25.
//

import SwiftUI

struct MovieSearchView: View {
    // 검색 로직 위함
    @StateObject private var viewModel = MovieSearchViewModel()
    @Binding var selectedMovie: Movie?
    @Environment(\.dismiss) private var dismiss
    private let columns = [GridItem(.adaptive(minimum: 95))]

    var body: some View {
        NavigationStack {
            ScrollView {
                Text("영화 선택").font(.PretendardSemiBold(size: 18))
                LazyVGrid(columns: columns, spacing: 30) {
                    ForEach(viewModel.searchResults) { movie in
                        Button( action: {
                            selectedMovie = movie
                            dismiss()
                        }) {
                            VStack(spacing: 8) {
                                Image(movie.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 95, height: 135)
                                Text(movie.name)
                                    .font(.PretendardSemiBold(size: 14))
                                    .foregroundStyle(.black)
                            }
                        }
                    }
                }.padding()
            }.searchable(text: $viewModel.query, prompt: "영화명을 입력해주세요.")
        }
    }
}




