import UIKit
import SwiftUI

/*
 사용 예시
 label.font = .sdGothic(.headlineBody, weight: .semibold)
 */

enum Typography {
    case largeTitle
    case title1
    case title2
    case title3
    case headlineBody
    case callout
    case caption1
    case caption2
    case caption3
    case tempLabel
    
    var fontSize: CGFloat {
        switch self {
        case .largeTitle:   return 34
        case .title1:       return 28
        case .title2:       return 22
        case .title3:       return 20
        case .headlineBody: return 17
        case .callout:      return 16
        case .caption1:     return 14
        case .caption2:     return 12
        case .caption3:     return 10
        case .tempLabel:    return 80
        }
    }
}

extension UIFont.Weight {
    var appleSDGothicNeoName: String {
            switch self {
            case .thin:       return "Thin"
            case .regular:    return "Regular"
            case .medium:     return "Medium"
            case .semibold:   return "SemiBold"
            default:          return "Regular"
            }
        }
        
        var sfProName: String {
            switch self {
            case .thin:       return "Thin"
            case .regular:    return "Regular"
            case .medium:     return "Medium"
            case .semibold:   return "Semibold"
            default:          return "Regular"
            }
        }
}

extension UIFont {
    static func sdGothic(_ style: Typography, weight: UIFont.Weight) -> UIFont {
        let font = "AppleSDGothicNeo"
        let weightString = weight.appleSDGothicNeoName
        let fontName = "\(font)-\(weightString)"
        let fontSize = style.fontSize
        
        guard let font = UIFont(name: fontName, size: fontSize) else {
            print("SystemFont: '\(fontName)'")
            return .systemFont(ofSize: fontSize, weight: weight)
        }
        
        return font
    }
    
    static func sfPro(_ style: Typography, weight: UIFont.Weight) -> UIFont {
        let font = style.fontSize < 20 ? "SFProText" : "SFProDisplay"
        let weightString = weight.sfProName
        let fontName = "\(font)-\(weightString)"
        let fontSize = style.fontSize
        
        guard let font = UIFont(name: fontName, size: fontSize) else {
            print("SystemFont: '\(fontName)'")
            return .systemFont(ofSize: fontSize, weight: weight)
        }
        
        return font
    }
}

// SwiftUI 용
extension Font {
    static func sdGothic(_ style: Typography, weight: UIFont.Weight) -> Font {
        Font(UIFont.sdGothic(style, weight: weight))
    }
    
    static func sfPro(_ style: Typography, weight: UIFont.Weight) -> Font {
        Font(UIFont.sfPro(style, weight: weight))
    }
}
