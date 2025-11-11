//
//  NavigationRoute.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/5/25.
//

import SwiftUI

// 앱에서 이동 가능한 모든 경로를 정의
enum Route: Hashable {
    
    case login
    
    case home
    case detail(movieCard: MovieCardDomainModel)
    
    case store
    
    case booking
    
    case userInfo
}
