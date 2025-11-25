//
//  MovieBoardModel.swift
//  UMC_Megabox
//
//  Created by 이한결 on 9/30/25.
//

import SwiftUI
import Foundation

struct MovieBoard: Identifiable {
    var id = UUID()
    var MovieImage: Image
    var Title: String
    var SubTitle: String
}
