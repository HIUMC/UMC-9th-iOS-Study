//
//  HomeModel.swift
//  MegaBox
//
//  Created by 박병선 on 10/2/25.
//
import Foundation

struct Movie : Identifiable {
    let id = UUID()
    let title: String
    let poster: String // 이미지 이름 or URL
    let audience: String
}

struct Feed: Identifiable {
    let id = UUID()
    let title: String
    let image: String
}

struct AdItem: Identifiable, Hashable {
    let id = UUID()
    let imageName: String
    let title: String
    let subtitle: String?
}
