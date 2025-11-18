//
//  MenuItemModel.swift
//  MEGABOX
//
//  Created by 고석현 on 11/15/25.
//


import Foundation

struct MenuItemModel: Identifiable, Hashable {
    let id = UUID()
    let imageName: String
    let title: String
    let price: Int
}
