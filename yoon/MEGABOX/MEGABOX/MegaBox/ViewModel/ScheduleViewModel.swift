//
//  ScheduleViewModel.swift
//  MEGABOX
//
//  Created by 정승윤 on 10/26/25.
//

import Foundation
import SwiftUI

class ScheduleViewModel: ObservableObject {
    @Published var schedule: ScheduleModel?
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
            let decoder = JSONDecoder()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            
            decoder.dateDecodingStrategy = .custom({ decoder in
                        let container = try decoder.singleValueContainer()
                        let dateString = try container.decode(String.self)
                        
                        // 정의한 dateFormatter를 사용하여 문자열을 Date로 변환 시도
                        if let date = dateFormatter.date(from: dateString) {
                            return date
                        }
                        
                        throw DecodingError.dataCorruptedError(
                            in: container,
                            debugDescription: "Invalid date format: \(dateString). Expected 'yyyy-MM-dd'."
                        )
                    })
            
            let response = try decoder.decode(ScheduleDTO.self, from: data)
            self.schedule = response.toDomain()
        } catch {
           errorMessage = "Decoding error: \(error)"
        }
        
        isLoading = false
    }
}
// MainActor 공부해보고 써보기
