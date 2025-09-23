//
//  ColorExtension.swift
//  MegaBox
//
//  Created by 박병선 on 9/23/25.
//
import SwiftUI

extension Color {
    /// HEX 문자열로 Color 생성 (예: "#FF5733" or "FF5733")
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let r, g, b, a: Double
        switch hexSanitized.count {
        case 6: // RGB (예: FF5733)
            r = Double((rgb & 0xFF0000) >> 16) / 255.0
            g = Double((rgb & 0x00FF00) >> 8) / 255.0
            b = Double(rgb & 0x0000FF) / 255.0
            a = 1.0
        case 8: // RGBA (예: FF5733FF)
            r = Double((rgb & 0xFF000000) >> 24) / 255.0
            g = Double((rgb & 0x00FF0000) >> 16) / 255.0
            b = Double((rgb & 0x0000FF00) >> 8) / 255.0
            a = Double(rgb & 0x000000FF) / 255.0
        default:
            r = 1; g = 1; b = 1; a = 1 // 잘못된 hex 값일 경우 흰색 반환
        }

        self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
    }
}
