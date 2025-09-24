//
//  week1_homeworkApp.swift
//  week1_homework
//
//  Created by 정승윤 on 9/15/25.
//

import SwiftUI

@main
struct week1_homeworkApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView(loginInput: LoginViewModel())
        }
    }
}
