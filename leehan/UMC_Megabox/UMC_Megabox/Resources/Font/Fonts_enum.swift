//
//  Fonts_enum.swift
//  UMC_Megabox
//
//  Created by OOng E on 9/16/25.
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
    
    static func pretend(_ type: Pretend, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }

    //extraBold
    static var ExtraBold24: Font {
        return .pretend(.extraBold, size: 24)
    }
    
    //bold
    static var Bold18: Font {
        return .pretend(.bold, size: 18)
    }
    
    static var Bold22: Font {
        return .pretend(.bold, size: 22)
    }
    
    static var Bold24: Font {
        return .pretend(.bold, size: 24)
    }
    
    //semiBold
    static var SemiBold38: Font {
        return .pretend(.semibold, size: 38)
    }
    
    static var SemiBold24: Font {
        return .pretend(.semibold, size: 24)
    }
    
    static var SemiBold18: Font {
        return .pretend(.semibold, size: 18)
    }
    
    static var SemiBold16: Font {
        return .pretend(.semibold, size: 16)
    }
    
    static var SemiBold14: Font {
        return .pretend(.semibold, size: 14)
    }
    
    static var SemiBold13: Font {
        return .pretend(.semibold, size: 13)
    }
    
    static var SemiBold12: Font {
        return .pretend(.semibold, size: 12)
    }
    
    //regular
    static var regular20: Font {
        return .pretend(.regular, size: 20)
    }
    
    static var regular18: Font {
        return .pretend(.regular, size: 18)
    }

    static var regular13: Font {
        return .pretend(.regular, size: 13)
    }
    
    static var regular12: Font {
        return .pretend(.regular, size: 12)
    }
    
    static var regular9: Font {
        return .pretend(.regular, size: 9)
    }
    
    //medium
    static var medium18: Font {
        return .pretend(.medium, size: 18)
    }
    
    static var medium16: Font {
        return .pretend(.medium, size: 16)
    }
    
    static var medium14: Font {
        return .pretend(.medium, size: 14)
    }
    
    static var medium13: Font {
        return .pretend(.medium, size: 13)
    }
    
    static var medium10: Font {
        return .pretend(.medium, size: 10)
    }
    
    static var medium8: Font {
        return .pretend(.medium, size: 8)
    }
    
    //light
    static var light14: Font {
        return .pretend(.light, size: 14)
    }

    
}
