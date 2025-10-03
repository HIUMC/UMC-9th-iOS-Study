//
//  LoginViewModel.swift
//  UMC_Megabox
//
//  Created by OOng E on 9/22/25.
//

import SwiftUI
import Observation

@Observable
class LoginViewModel {
    /* LoginViewModel 에서 LoginModel 초기화 */
    var loginModel: LoginModel = .init(id: "", pwd: "")
}


