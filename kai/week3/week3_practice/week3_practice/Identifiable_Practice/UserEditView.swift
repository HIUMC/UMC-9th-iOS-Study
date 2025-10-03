//
//  UserEditView.swift
//  week3_practice
//
//  Created by 김지우 on 10/3/25.
//

import SwiftUI

struct UserEditView: View {
    @Binding var user: User  // 상위 뷰에서 전달받은 데이터

    var body: some View {
        Form {
            TextField("Name", text: $user.name)
            Stepper("Age: \(user.age)", value: $user.age, in: 18...100)
        }
    }
}

