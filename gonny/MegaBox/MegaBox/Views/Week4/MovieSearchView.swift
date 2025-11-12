//
//  MovieSearchView.swift
//  MegaBox
//
//  Created by 박병선 on 10/9/25.
//
import SwiftUI

struct MovieSearchView: View {
    @StateObject private var vm = MovieSearchViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.primary)

                    TextField("영화명을 입력해주세요", text: $vm.query)
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

                if vm.isLoading {
                    ProgressView("검색 중...")
                }

                if let error = vm.errorMessage {
                    Text(error).foregroundStyle(.red)
                }

            }
            .navigationTitle("영화 검색")
        }
    }
}

#Preview {
    MovieSearchView()
}
