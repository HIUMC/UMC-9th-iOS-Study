//
//  UserViewModel.swift
//  week2_Practice
//
//  Created by 정승윤 on 9/20/25.
//

import Foundation

class UserViewModel1: ObservableObject {
    
    @Published var userModel: UserModel
    
    init(userModel: UserModel) {
        self.userModel = userModel
    }
    
    func increaseAge() {
        self.userModel.increaseAge()
    }
    
    func decreaseAge() {
        self.userModel.decreaseAge()
    }
    
}
