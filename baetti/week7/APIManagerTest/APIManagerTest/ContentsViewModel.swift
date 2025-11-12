//
//  ContentsViewModel.swift
//  APIManagerTest
//
//  Created by 박정환 on 11/11/25.
//

import Foundation
import Moya

@Observable
class ContentsViewModel {
    var userData: UserData?
    let provider: MoyaProvider<UserRotuer>
    
    init(provider: MoyaProvider<UserRotuer>) {
        self.provider = provider
    }
    
    /// 메인 액터로 명확하게 격리
    @MainActor
    convenience init() {
        self.init(provider: APIManager.shared.createProvider(for: UserRotuer.self))
    }
    
    func getUser(name: String) async {
        do {
            let response = try await provider.requestAsync(.getPerson(name: name))
            let user = try JSONDecoder().decode(UserData.self, from: response.data)
            print("유저", user)
        } catch {
            print("요청 또는 디코딩 실패:", error.localizedDescription)
        }
    }
    
    func createUser(_ userData: UserData) {
        provider.request(.postPerson(userData: userData)) { result in
            switch result {
            case .success(let response):
                print("POST 성공: \(response.statusCode)")
            case .failure(let error):
                // Error 처리 넣기
                print("error", error)
            }
        }
    }
    
    func updateUserPatch(_ patchData: UserPatchRequest) {
        provider.request(.patchPerson(patchData: patchData)) { result in
            switch result {
            case .success(let response):
                print("PATCH 성공: \(response.statusCode)")
            case .failure(let error):
                // Error 처리 넣기
                print("error", error)
            }
        }
    }
    
    func updateUserPut(_ userData: UserData) {
        provider.request(.putPerson(userData: userData)) { result in
            switch result {
            case .success(let response):
                print("PUT 성공: \(response.statusCode)")
            case .failure(let error):
                // Error 처리
                print("error", error)
            }
        }
    }
    
    func deleteUser(name: String) {
        provider.request(.deletePerson(name: name)) { result in
            switch result {
            case .success(let response):
                print("DELETE 성공: \(response.statusCode)")
            case .failure(let error):
                // Error 처리
                print("error", error)
            }
        }
    }
}


extension MoyaProvider {
        // Moya를 async/await로 호출할 수 있도록 하는 함수
    func requestAsync(_ target: Target) async throws -> Response {
        try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

