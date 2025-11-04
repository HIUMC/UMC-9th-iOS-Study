//
//  InfoViewModel.swift
//  Megabox
//
//  Created by 김지우 on 9/24/25.
//

import Foundation
@Observable
class InfoViewModel {
    let infoModel : [InfoModel] = [
        .init(icon: "permovie", label: "영화별예매"),
        .init(icon: "pertheater", label: "극장별예매"),
        .init(icon: "specialTheater", label: "특별관예매"),
        .init(icon: "mobileOrder", label: "모바일오더")
    ]
    
}
