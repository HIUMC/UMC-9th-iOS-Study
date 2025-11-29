//
//  LocationBarStyleModifier.swift
//  MEGABOX
//
//  Created by 박정환 on 11/19/25.
//

import SwiftUI

// MARK: - EnvironmentKey for Button Border Color
private struct TheaterButtonBorderColorKey: EnvironmentKey {
    static let defaultValue: Color = .black
}

extension EnvironmentValues {
    var theaterButtonBorderColor: Color {
        get { self[TheaterButtonBorderColorKey.self] }
        set { self[TheaterButtonBorderColorKey.self] = newValue }
    }
}

extension View {
    func theaterButtonBorder(_ color: Color) -> some View {
        environment(\.theaterButtonBorderColor, color)
    }
}



// MARK: - White Style
struct WhiteLocationBarStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.black)
            .tint(Color.purple03)
            .theaterButtonBorder(.black)
            .background(Color.white)
    }
}

// MARK: - Purple Style
struct PurpleLocationBarStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .tint(.white)
            .theaterButtonBorder(.white)
            .background(Color.purple03)
    }
}

extension View {
    func whiteStyle() -> some View {
        self.modifier(WhiteLocationBarStyle())
    }

    func purpleStyle() -> some View {
        self.modifier(PurpleLocationBarStyle())
    }
}
