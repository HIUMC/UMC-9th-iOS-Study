//
//  Fonts.swift
//  Megabox
//
//  Created by 김지우 on 9/18/25.
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
        case extraLight
        case thin
        
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
            case .extraLight:
                return "Pretendard-ExtraLight"
            case .thin:
                return "Pretendard-Thin"
            }
        }
    }
    
    static func pretend(type: Pretend, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    static func PretendardBold(size: CGFloat) -> Font {
        return .pretend(type: .bold, size: size)
    }
    
    static func PretendardMedium(size: CGFloat) -> Font {
        return .pretend(type: .medium, size: size)
    }
    
    static func PretendardExtraBold(size: CGFloat) -> Font {
        return .pretend(type: .extraBold, size: size)
    }
    
    static func PretendardRegular(size: CGFloat) -> Font {
        return .pretend(type: .regular, size: size)
    }
    
    static func PretendardSemiBold(size: CGFloat) -> Font {
        return .pretend(type: .semibold, size: size)
    }
    
    static func PretendardLight(size: CGFloat) -> Font {
        return .pretend(type: .medium, size: size)
    }
    
    static func PretendardExtraLight(size: CGFloat) -> Font {
        return .pretend(type: .extraLight, size: size)
    }
    
    static func PretendardThin(size: CGFloat) -> Font {
        return .pretend(type: .thin, size: size)
    }
    
    
    /*
     나중에 사용할 때에는 이렇게 씀
     
     Text("Hello, SwiftUI!")
         .font(.PretendardMedium(size: 16))
     
     */
}
