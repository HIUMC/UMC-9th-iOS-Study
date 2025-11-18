//
//  MenuItemModel.swift
//  UMC_Megabox
//
//  Created by 이한결 on 11/15/25.
//

import Foundation

struct MenuItemModel: Identifiable, Hashable {
    let id: UUID = UUID()
    let menuImage: String
    let menuName: String
    let menuPrice: String
}
