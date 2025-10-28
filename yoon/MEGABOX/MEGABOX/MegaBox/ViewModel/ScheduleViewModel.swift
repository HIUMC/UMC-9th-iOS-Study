//
//  ScheduleViewModel.swift
//  MEGABOX
//
//  Created by 정승윤 on 10/26/25.
//

import Foundation
import SwiftUI

class ScheduleViewModel: ObservableObject {
    @Published var schedule: [ScheduleModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func fetchSchedule() async {
        isLoading = true
        
        guard let url = Bundle.main.url(
            forResource: "MovieSchedule", withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
           
            errorMessage = "JSON 파일 없음"
            isLoading = false
            return
        }
        
        do {
            let response = try JSONDecoder().decode(ScheduleDTO.self, from: data)
            self.schedule = [response.toDomain()]
        } catch {
           errorMessage = "Decoding error: \(error)"
        }
        
        isLoading = false
    }
}
