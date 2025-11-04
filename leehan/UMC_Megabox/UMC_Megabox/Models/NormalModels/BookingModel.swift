//
//  BookingModels.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/5/25.
//

import Foundation


struct Movie: Identifiable, Hashable {
    let id: String
    let name: String
    let imageName: String
    let ageRating: Int
}

struct Theater: Identifiable, Hashable {
    let id: UUID = UUID()
    let name: String
}

struct Showtime: Identifiable, Hashable {
    let id: String
    let movieId: String
    let theaterId: String
    let time: String
    let totalSeats: Int
    let availableSeats: Int
}


