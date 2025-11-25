//
//  Untitled.swift
//  MegaBox
//
//  Created by 박병선 on 11/13/25.
//
import Moya

// Moya의 request(...) 콜백 기반 API를 Swift async/await 형태로 래핑하는 확장
extension MoyaProvider {
    func asyncRequest(_ target: Target) async throws -> Response {
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
