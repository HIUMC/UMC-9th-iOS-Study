//
//  TextViewModel.swift
//  week2_Practice
//
//  Created by 정승윤 on 9/21/25.
//

import SwiftUI

class TextViewModel: ObservableObject {
    @Published var inputText: String = ""

    init() {
        print("✅ 새로운 TextViewModel 인스턴스 생성됨! ✅")
    }
}

