//
//  LoginViewModel.swift
//  MEGABOX
//
//  Created by 박정환 on 9/23/25.
//

import Foundation

@Observable
class LoginViewModel: ObservableObject {
    var loginModel: LoginModel = .init(id: "", pwd: "", nickname: "")
}
