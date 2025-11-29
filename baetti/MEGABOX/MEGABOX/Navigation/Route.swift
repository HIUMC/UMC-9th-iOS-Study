//
//  Route.swift
//  MEGABOX
//
//  Created by 박정환 on 10/1/25.
//

import SwiftUI

enum Route: Equatable, Hashable {
    case login
    case mobileOrderDetail
    case profile
    case detail(MovieModel)
}
