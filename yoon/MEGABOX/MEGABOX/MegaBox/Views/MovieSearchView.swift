//
//  MovieSearchView.swift
//  MEGABOX
//
//  Created by 정승윤 on 10/8/25.
//

import Foundation
import SwiftUI
import Combine

struct MovieSearchView: View {
    @StateObject private var vm = MovieSearchViewModel()
    
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        NavigationStack {
            VStack (alignment:.center, spacing:36){
                Text("영화 선택")
                    .font(.PretendardsemiBold18)
                
                if vm.query.isEmpty {
                    LazyVGrid(columns:columns,spacing: 36 ) {
                        ForEach(vm.movies, id: \.id) {movie in
                            // 라벨
                            VStack(spacing: 8){
                                Image(movie.posterName)
                                    .resizable()
                                    .frame(width:95,height:135)
                                Text(movie.name)
                                    .font(.PretendardsemiBold14)
                            }
                            // 라벨
                        }
                    }
                }
                if vm.isLoading {
                    ProgressView("검색중…")
                }
                
                else if let error = vm.errorMessage {
                    Text(error).foregroundStyle(.red)
                }
                else {
                    LazyVGrid(columns:columns,spacing: 36 ) {
                        ForEach(vm.results, id: \.id) {movie in
                            VStack(spacing: 8){
                                Image(movie.posterName)
                                    .resizable()
                                    .frame(width:95,height:135)
                                Text(movie.name)
                                    .font(.PretendardsemiBold14)
                            }
                        }
                    }
                }
                Spacer()
                
                TextField("영화명을 입력해주세요", text: $vm.query)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
            }
            }.padding(.horizontal,16)
               
        }
    }

struct MovieSearchView_Preview: PreviewProvider {
    static var previews: some View {
        devicePreviews {
            MovieSearchView()
                .environment(NavigationRouter())
            
        }
    }
}
