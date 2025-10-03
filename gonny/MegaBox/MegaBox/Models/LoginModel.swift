//
//  LoginModel.swift
//  MegaBox
//
//  Created by 박병선 on 9/23/25.
//
import Foundation

@Observable
class LoginModel {
    var id: String = ""
    var pwd: String = ""
    var profile: Profile = Profile() //얘도 추가하긴 했는데
}

