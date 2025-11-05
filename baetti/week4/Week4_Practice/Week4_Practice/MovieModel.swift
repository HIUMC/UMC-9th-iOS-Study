//
//  MovieModel.swift
//  Week4_Practice
//
//  Created by 박정환 on 10/7/25.
//

import Foundation
import SwiftUI

struct MovieModel: Identifiable {
    let id: UUID = .init()
    let movieImage: Image
    let title: String
    let rate: Double
}
