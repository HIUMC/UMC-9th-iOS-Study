//
//  User.swift
//  week3_practice
//
//  Created by 김지우 on 10/3/25.
//

import Foundation

struct User: Identifiable {
    let id = UUID()
    var name: String
    var age: Int
}
