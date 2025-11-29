//
//  Route.swift
//  week1_homework
//
//  Created by 정승윤 on 10/2/25.
//

import SwiftUI

enum Route: Hashable, Equatable {
    case home
    case login
    case detail(MovieCardModel)
    case profile
    case userSetting
    case menuDetail
}
