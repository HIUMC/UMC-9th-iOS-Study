//
//  MenuItemModel.swift
//  Megabox
//
//  Created by 김지우 on 11/20/25.
//

import Foundation

struct MenuItemModel: Identifiable, Hashable {
    let id: UUID = UUID()
    let menuImage: String
    let menuName: String
    let menuPrice: String
}
