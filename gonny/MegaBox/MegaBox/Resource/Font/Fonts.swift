//
//  Fonts.swift
//  MegaBox
//
//  Created by 박병선 on 9/16/25.
//

import Foundation
import SwiftUI

extension Font {
    enum Pretend {
        case extraBold
        case bold
        case semibold
        case medium
        case regular
        case light
        
        var value: String {
            switch self {
            case .extraBold:
                return "Pretendard-ExtraBold"
            case .bold:
                return "Pretendard-Bold"
            case .semibold:
                return "Pretendard-SemiBold"
            case .medium:
                return "Pretendard-Medium"
            case .regular:
                return "Pretendard-Regular"
            case .light:
                return "Pretendard-Light"
            }
        }
    }
    
    static func pretend(type: Pretend, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    static func pretendardLight(_ size: CGFloat) -> Font {
        return .pretend(type: .light, size: size)
    }
    
    static func pretendardRegular(_ size: CGFloat) -> Font {
        return .pretend(type: .regular, size: size)
    }
    
    static func pretendardMedium(_ size: CGFloat) -> Font {
        return .pretend(type: .medium, size: size)
    }
    
    static func pretendardBold(_ size: CGFloat) -> Font {
        return .pretend(type: .bold, size: size)
    }
    
    static func pretendardSemiBold(_ size: CGFloat) -> Font {
        return .pretend(type: .semibold, size: size)
    }
    
    static func PretendardExtraBold(_ size: CGFloat) -> Font {
        return .pretend(type: .extraBold, size: size)
    }
}

