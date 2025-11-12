//
//  TheaterModel.swift
//  MEGABOX
//
//  Created by 정승윤 on 10/7/25.
//

import Foundation


class TheaterModel: Identifiable, Hashable {
    let id: String
    let name: String

    init(name: String) {
        self.name = name
        self.id = name
    }

    static func == (lhs: TheaterModel, rhs: TheaterModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

enum Theaters: String, CaseIterable {
    case gangnam = "강남"
    case hongdae = "홍대"
    case sinchon = "신촌"

}
