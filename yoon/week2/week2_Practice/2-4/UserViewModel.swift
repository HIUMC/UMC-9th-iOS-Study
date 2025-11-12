//
//  UserViewModel.swift
//  week2_Practice
//
//  Created by 정승윤 on 9/21/25.
//

//import SwiftUI
//
//class UserViewModel: ObservableObject {
//    @Published var username: String = "초기 사용자"
//}

import Foundation

/* 뷰모델 */

@Observable
class UserViewModel {
    var username: String = "초기 사용자"
}
