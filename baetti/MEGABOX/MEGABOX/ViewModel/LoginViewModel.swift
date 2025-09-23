//
//  LoginViewModel.swift
//  MEGABOX
//
//  Created by 박정환 on 9/23/25.
//

import Foundation
import Observation
import SwiftUI

@Observable
class LoginViewModel {
    private(set) var model: LoginModel

    init(model: LoginModel = .init(id: "", pwd: "", nickname: "")) {
        self.model = model
    }

    var id: String {
        get { model.id }
        set { model.id = newValue }
    }

    var pwd: String {
        get { model.pwd }
        set { model.pwd = newValue }
    }

    var nickname: String {
        get { model.nickname }
        set { model.nickname = newValue }
    }
}
