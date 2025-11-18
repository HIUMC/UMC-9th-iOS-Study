//
//  SelectTheaterBar.swift
//  MegaBox
//
//  Created by 이서현 on 11/18/25.
//

import SwiftUI

struct SelectTheaterBar: View {

  enum Style {
    case purple
    case plain
  }

  let style: Style
  let theaterName: String
  var onTapChange: () -> Void = {}

  // MARK: - Body

  var body: some View {
    HStack(spacing: 0) {
      Image(.mappin)
        .resizable()
        .modifier(MappinStyle(tint: iconColor))

      Text(theaterName)
        .modifier(TheaterLabelStyle(color: titleColor))
        .padding(.leading, 8)

      Spacer()

      Button(action: onTapChange) {
        Text("극장 변경")
      }
      .modifier(
        TheaterButtonStyle(
          textColor: buttonTextColor,
          borderColor: buttonBorderColor,
          backgroundColor: buttonBackgroundColor
        )
      )
    }
    .padding(.horizontal, 16)
    .padding(.vertical, 14)
    .background(backgroundColor)
  }

  
  
  private var backgroundColor: Color {
    switch style {
    case .purple: return .purple04
    case .plain:  return .white
    }
  }

  private var iconColor: Color {
    switch style {
    case .purple: return .white
    case .plain:  return .black
    }
  }

  private var titleColor: Color {
    switch style {
    case .purple: return .white
    case .plain:  return .black
    }
  }

  private var buttonTextColor: Color {
    switch style {
    case .purple: return .white
    case .plain:  return .purple04
    }
  }

  private var buttonBorderColor: Color {
    switch style {
    case .purple: return .white
    case .plain:  return .gray06
    }
  }

  private var buttonBackgroundColor: Color {
    switch style {
    case .purple: return .clear
    case .plain:  return .white
    }
  }
}

// MARK: - Modifier

struct MappinStyle: ViewModifier {
  var tint: Color

  func body(content: Content) -> some View {
    content
      .foregroundStyle(tint)
      .frame(width: 27, height: 27)
  }
}

struct TheaterLabelStyle: ViewModifier {
  var color: Color

  func body(content: Content) -> some View {
    content
      .font(.PretendardSemiBold13)
      .foregroundStyle(color)
  }
}

struct TheaterButtonStyle: ViewModifier {
  var textColor: Color
  var borderColor: Color
  var backgroundColor: Color = .clear

  func body(content: Content) -> some View {
    content
      .font(.PretendardSemiBold13)
      .foregroundStyle(textColor)
      .padding(.horizontal, 12)
      .padding(.vertical, 6)
      .background(backgroundColor)
      .overlay(
        RoundedRectangle(cornerRadius: 5)
          .stroke(borderColor, lineWidth: 1)
      )
      .clipShape(RoundedRectangle(cornerRadius:5))
  }
}


// MARK: - Previews

#Preview("Purple") {
  SelectTheaterBar(
    style: .purple,
    theaterName: "강남"
  )
}

#Preview("Plain") {
  SelectTheaterBar(
    style: .plain,
    theaterName: "강남"
  )
}
