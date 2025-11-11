//
//  Model.swift
//  week4_practice
//
//  Created by 고석현 on 10/9/25.
//
import Foundation
import SwiftUI

struct MovieModel: Identifiable {
    let id: UUID = .init()
    let movieImage: Image
    let title: String
    let rate: Double
}
