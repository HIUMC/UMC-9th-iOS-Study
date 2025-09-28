//
//  Fonts.swift
//  1st_work
//
//  Created by 박정환 on 3/22/25.
//

import Foundation
import SwiftUI

extension Font {
    enum Pretendard {
        case extraBold
        case bold
        case semiBold
        case medium
        case regular
        case light
        
        var value: String {
            switch self {
            case .extraBold:
                return "Pretendard-ExtraBold"
            case .bold:
                return "Pretendard-Bold"
            case .semiBold:
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
    
    static func pretendard(type: Pretendard, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    static var extraBold24: Font {
        return .pretendard(type: .extraBold, size: 24)
    }
    
    static var bold18: Font {
        return .pretendard(type: .bold, size: 18)
    }
    
    static var bold22: Font {
        return .pretendard(type: .bold, size: 22)
    }
    
    static var bold24: Font {
        return .pretendard(type: .bold, size: 24)
    }
    
    static var semiBold38: Font {
        return .pretendard(type: .semiBold, size: 38)
    }
    
    static var semiBold24: Font {
        return .pretendard(type: .semiBold, size: 24)
    }
    
    static var semiBold18: Font {
        return .pretendard(type: .semiBold, size: 18)
    }
    
    static var semiBold16: Font {
        return .pretendard(type: .semiBold, size: 16)
    }
    
    static var semiBold14: Font {
        return .pretendard(type: .semiBold, size: 14)
    }

    static var semiBold13: Font {
        return .pretendard(type: .semiBold, size: 13)
    }
    
    static var semiBold12: Font {
        return .pretendard(type: .semiBold, size: 12)
    }
    
    static var regular20: Font {
        return .pretendard(type: .regular, size: 20)
    }
    
    static var regular18: Font {
        return .pretendard(type: .regular, size: 18)
    }
    
    static var regular13: Font {
        return .pretendard(type: .regular, size: 13)
    }
    
    static var regular12: Font {
        return .pretendard(type: .regular, size: 12)
    }
    
    static var regular9: Font {
        return .pretendard(type: .regular, size: 9)
    }
    
    static var medium18: Font {
        return .pretendard(type: .medium, size: 18)
    }
    
    static var medium16: Font {
        return .pretendard(type: .medium, size: 16)
    }
    
    static var medium14: Font {
        return .pretendard(type: .medium, size: 14)
    }
    
    static var medium13: Font {
        return .pretendard(type: .medium, size: 13)
    }
    
    static var medium10: Font {
        return .pretendard(type: .medium, size: 10)
    }
    
    static var medium8: Font {
        return .pretendard(type: .medium, size: 8)
    }
    
    static var light14: Font {
        return .pretendard(type: .light, size: 14)
    }
}
