//
//  MovieSearchSheet.swift
//  Megabox
//
//  Created by 김지우 on 10/9/25.
//

import SwiftUI

struct MovieSearchSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    
    @StateObject private var vm: MovieSearchViewModel
    
    //    (Movie) -> Void
    let onSelect: (Movie) -> Void
    
    //    [BookingMovie] -> [Movie]
    init(movies: [Movie], onSelect: @escaping (Movie) -> Void) {
        _vm = StateObject(wrappedValue: MovieSearchViewModel(allMovies: movies))
        self.onSelect = onSelect
    }
    
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 3)
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
             
            Text("영화 선택")
                .font(.PretendardBold(size: 18))
                .foregroundColor(.black01)
               
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                   
                    ForEach(vm.filteredMovies) { movie in
                        VStack(spacing: 8) {
                            Button {
                                onSelect(movie)
                                dismiss()
                            } label: {
                                //    movie.posterAsset
                                Image(movie.posterAsset)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 98, height: 140)
                                    .clipped()
                                    .cornerRadius(10)
                            }
                            .buttonStyle(.plain)
                               
                            Text(movie.title)
                                .font(.system(size: 12))
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                                .frame(maxWidth: 110)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 90) // 검색바 안전 여백
            }
        }
        .background(Color(.systemBackground).ignoresSafeArea())
        .safeAreaInset(edge: .bottom) {
            HStack(spacing: 12) {
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.medium)
                        .foregroundStyle(.secondary)
                   
                    TextField("영화명을 입력해주세요", text: $vm.searchText)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .font(.system(size: 15))
                        .foregroundStyle(.primary)
                        .tint(.purple)
                   
                    Button {
                        // 마이크 액션 (디자인만)
                    } label: {
                        Image(systemName: "mic.fill")
                            .imageScale(.medium)
                    }
                    .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 14)
                .frame(height: 48)
                .background(.ultraThinMaterial, in: Capsule())
                .overlay(
                    Capsule().strokeBorder(Color.white.opacity(0.25), lineWidth: 0.7)
                )
                .shadow(color: .black.opacity(0.08), radius: 8, y: 3)
                
                Button {
                    vm.clear()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.secondary)
                        .frame(width: 40, height: 40)
                        .background(
                            Circle()
                                .fill(.ultraThinMaterial)
                                .overlay(
                                    Circle().stroke(Color.white.opacity(0.25), lineWidth: 0.7)
                                )
                        )
                        .shadow(color: .black.opacity(0.08), radius: 8, y: 3)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 16)
            .background(
                Color.clear
                    .ignoresSafeArea()
                    .shadow(color: .black.opacity(0.04), radius: 3, y: -2)
            )
        }
    }
}

#Preview {
     let samples: [Movie] = [
        .init(id: "m-003", title: "귀멸의 칼날: 무한성", ageRating: "15", schedules: [], posterAsset: "demonslayer"),
        .init(id: "m-002", title: "F1 더 무비", ageRating: "12", schedules: [], posterAsset: "f1"),
        .init(id: "m-001", title: "어쩔수가없다", ageRating: "15", schedules: [], posterAsset: "nootherchoice")
     ]
     MovieSearchSheet(movies: samples) { _ in }
}
