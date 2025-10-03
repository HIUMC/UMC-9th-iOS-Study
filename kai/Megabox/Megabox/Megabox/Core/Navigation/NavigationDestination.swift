//
//  NavigationDestination.swift
//  Megabox
//
//  Created by 김지우 on 10/2/25.
//

import SwiftUI

//반드시 Hashable로 채택해야 함!!

enum NavigationDestination: Hashable {
    
    //로그인
    case login

    //홈
    case home
    case detail(MovieCardModel)

    //영화 예매
    case booking
    
    //모바일오더
    case order
    
    //마이페이지
    case userinfo
}
