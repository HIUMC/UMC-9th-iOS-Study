//
//  UserViewModel.swift
//  week5_practice
//
//  Created by 정승윤 on 10/22/25.
//

import Foundation
import Combine

class UserListViewModel: ObservableObject {
    @Published var users: [UserModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // 임시 데이터
    private var userStore: [UserModel] = [
        UserModel(id: "1", name: "River", profileImageURL: nil, bio: "iOS Developer"),
        UserModel(id: "2", name: "David", profileImageURL: nil, bio: "Backend Developer"),
        UserModel(id: "3", name: "Sarah", profileImageURL: nil, bio: "Designer")
    ]
    
    func addUser(name: String, bio: String) {
        let newUser = UserModel(
            id: UUID().uuidString,
            name: name,
            profileImageURL: nil,
            bio: bio
        )
        userStore.append(newUser)
        users = userStore
    }
    
    func fetchUsers() async {
        isLoading = true
        
        // Bundle에서 JSON 파일 읽기
            guard let url = Bundle.main.url(
                forResource: "MockData", withExtension: "json"),
                  let data = try? Data(contentsOf: url) else { return }

            do {
                let response = try JSONDecoder().decode(APIResponse.self, from: data)
                
                await MainActor.run {
                        // users 프로퍼티에 저장(View에 자동으로 데이터 반영)
                    self.users = response.data.users.map { $0.toDomain() }
                    self.isLoading = false
                }
            } catch {
                print("Decoding error:", error)
            }
        }
    
    func updateUser(id: String, name: String, bio: String) {
        if let index = userStore.firstIndex(where: { $0.id == id }) {
            userStore[index] = UserModel(
                id: id,
                name: name,
                profileImageURL: userStore[index].profileImageURL,
                bio: bio
            )
            users = userStore
        }
    }
    
    func deleteUser(id: String) {
        userStore.removeAll { $0.id == id }
        users = userStore
    }
}
