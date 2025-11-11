//
//  MovieSearchView.swift
//  week4_practice
//
//  Created by 이서현 on 10/5/25.
//

import SwiftUI

struct MovieSearchView: View {
    @StateObject private var vm = MovieSearchViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                TextField("영화 명을 입력하세요", text: $vm.query)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                if vm.isLoading {
                    ProgressView("검색 중...")
                }
                
                if let error = vm.errorMessage {
                    Text(error).foregroundStyle(.red)
                }
                
                List(vm.results, id: \.id) { movie in
                    HStack {
                        movie.movieImage
                            .resizable()
                            .frame(width: 40, height: 56)
                        VStack(alignment: .leading) {
                            Text(movie.title).font(.headline)
                            
                            Spacer()
                            
                            Text(String(format: "%.1f", movie.rate))
                                .font(.subheadline).bold()
                        }
                        .padding(.horizontal, 10)
                    }
                }
            }
            .navigationTitle("영화 검색")
        }
    }
}

#Preview {
    MovieSearchView()
}
