//
//  UserModel.swift
//  week2_Practice
//
//  Created by 정승윤 on 9/20/25.
//

import Foundation

struct UserModel {
    var name: String
    var age: Int
    
    mutating func increaseAge() {
        self.age += 1
    }
    
    mutating func decreaseAge() {
        self.age -= 1
    }
}
