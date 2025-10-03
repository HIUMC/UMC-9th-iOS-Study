//
//  InfoModel.swift
//  Megabox
//
//  Created by 김지우 on 9/24/25.
//

// InfoModel.swift
import Foundation

struct InfoModel: Identifiable, Hashable {
    let id = UUID()
    let icon: String   // 에셋 이름 (permovie, pertheater, ...)
    let label: String  // 표시 텍스트
}
