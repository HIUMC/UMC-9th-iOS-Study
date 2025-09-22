//
//  Fonts.swift
//  week1_practice
//
//  Created by 고석현 on 9/17/25.
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
        case thin
        case black
        
        
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
            case .thin:
                return "Pretendard-Thin"
            case .black:
                return "Pretendard-Black"
            }
        }
    }
    
    static func pretend(type: Pretend, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    static var PretendardBold30: Font {
        return .pretend(type: .bold, size: 30)
    }
    static var PretendardRegualr16: Font {
        return .pretend(type: .regular, size: 16)
    }
    static var PretendardBold24: Font {
        return .pretend(type: .bold, size: 24)
    }
    static var PretendardSemiBold18: Font {
        return .pretend(type: .semibold, size: 18)
    }
    
    /* 여기에 더 추가해주세요 */
    
}
