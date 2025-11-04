//
//  ListFlowViewModel.swift
//  week4_practice
//
//  Created by 정승윤 on 10/7/25.
//

import Combine
import SwiftUI

final class ListFlowViewModel: ObservableObject {
    @Published var items: [String] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    @Published private var reloadTick: Int = 0
    private var bag = Set<AnyCancellable>()
    
    init() {
        $reloadTick
            .map { _ in
                Self.mockLoad()
                    .handleEvents(
                        receiveSubscription: { _ in self.isLoading = true },
                        receiveCompletion:   { _ in self.isLoading = false },
                        receiveCancel:       {    self.isLoading = false }
                    )
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let e) = completion {
                    self?.errorMessage = e.localizedDescription
                }
            } receiveValue: { [weak self] values in
                self?.errorMessage = nil
                self?.items = values
            }
            .store(in: &bag)
    }
    
    func onReloadTap() { reloadTick &+= 1 }
    
    private static func mockLoad() -> AnyPublisher<[String], Error> {
        Deferred {
            Future { promise in
                DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                    promise(.success(["A", "B", "C"]))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
