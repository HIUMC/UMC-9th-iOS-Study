//
//  Fonts.swift
//  week1_homework
//
//  Created by 정승윤 on 9/15/25.
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
    
    static var PretendardBold18: Font {
        return .pretend(type: .bold, size: 18)
    }
    
    static var PretendardBold22: Font {
        return .pretend(type: .bold, size: 22)
    }
    
    static var PretendardBold24: Font {
        return .pretend(type: .bold, size: 24)
    }
    
    static var PretendardextraBold24: Font {
        return .pretend(type:.extraBold, size: 24)
    }
    
    static var PretendardsemiBold38: Font {
        return .pretend(type:.semibold, size: 38)
    }
    
    static var PretendardsemiBold24: Font {
        return .pretend(type:.semibold, size: 24)
    }
    
    static var PretendardsemiBold18: Font {
        return .pretend(type:.semibold, size: 18)
    }
    
    static var PretendardsemiBold16: Font {
        return .pretend(type:.semibold, size: 16)
    }
    
    static var PretendardsemiBold14: Font {
        return .pretend(type:.semibold, size: 14)
    }
    
    static var PretendardsemiBold13: Font {
        return .pretend(type:.semibold, size: 13)
    }
    
    static var PretendardsemiBold12: Font {
        return .pretend(type:.semibold, size: 12)
    }
    
    static var Pretendardregular20: Font {
        return .pretend(type:.regular, size: 20)
    }
    
    static var Pretendardregular18: Font {
        return .pretend(type:.regular, size: 18)
    }
    
    static var Pretendardregular13: Font {
        return .pretend(type:.regular, size: 13)
    }
    static var Pretendardregular12: Font {
        return .pretend(type:.regular, size: 12)
    }
    
    static var Pretendardregular09: Font {
        return .pretend(type:.regular, size: 09)
    }
    
    static var Pretendardmedium18: Font {
        return .pretend(type:.medium, size: 18)
    }
    
    static var Pretendardmedium16: Font {
        return .pretend(type:.medium, size: 16)
    }
    
    static var Pretendardmedium14: Font {
        return .pretend(type:.medium, size: 14)
    }
    
    static var Pretendardmedium13: Font {
        return .pretend(type:.medium, size: 13)
    }
    
    static var Pretendardmedium10: Font {
        return .pretend(type:.medium, size: 10)
    }
    
    static var Pretendardmedium08: Font {
        return .pretend(type:.medium, size: 08)
    }
    
    static var Pretendardlight14: Font {
        return .pretend(type:.light, size: 14)
    }
}
