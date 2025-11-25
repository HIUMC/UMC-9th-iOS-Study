//
//  Fonts.swift
//  Week1_Practice
//
//  Created by 박정환 on 9/16/25.
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
    
    static var PretendardBold30: Font {
        return .pretend(type: .bold, size: 30)
    }
    
    /* 여기에 더 추가해주세요 */
    static var PretendardRegular16: Font {
        return .pretend(type: .regular, size: 16)
    }
    
    static var PretendardBold24: Font {
        return .pretend(type: .bold, size: 24)
    }

    static var PretendardSemiBold18: Font {
        return .pretend(type: .semibold, size: 18)
    }
}
