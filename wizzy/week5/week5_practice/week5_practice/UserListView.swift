//
//  UserListView.swift
//  week5_practice
//
//  Created by 이서현 on 10/25/25.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel = UserListViewModel()
    @State private var showAddUser = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isLoading {
                    ProgressView("로딩 중...")
                } else {
                    List {
                        ForEach(viewModel.users, id: \.id) { user in
                            UserRowView(user: user)
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { index in
                                viewModel.deleteUser(id: viewModel.users[index].id)
                            }
                        }
                    }
                }
            }
            .navigationTitle("사용자 목록")
            .toolbar {
                Button {
                    showAddUser = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .task {
                await viewModel.fetchUsers()
            }
        }
    }
}

struct UserRowView: View {
    let user: UserModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(user.displayName)
                .font(.headline)
            Text(user.bio)
                .font(.subheadline)
                .foregroundStyle(.gray)
            
            if user.isProfileComplete {
                Label("프로필 완성", systemImage: "checkmark.circle.fill")
                    .font(.caption)
                    .foregroundStyle(.green)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    UserListView()
}
