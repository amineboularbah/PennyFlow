//
//  Font+Extension.swift
//  pennyflow
//
//  Created by Amine on 29/11/2024.
//
import SwiftUI

enum Inter: String {
    case regular = "Inter-Regular"
    case medium = "Inter-Medium"
    case semibold = "Inter-SemiBold"
    case bold = "Inter-Bold"
}

extension Font {
    
    /// Returns a custom font with the specified style and size.
    static func customFont(_ font: Inter, fontSize: CGFloat) -> Font {
        custom(font.rawValue, size: fontSize)
    }
    
    // Typography System
    
    // Display Styles
    static var display1: Font { customFont(.bold, fontSize: 72) }
    
    // Headline Styles
    static var headline1: Font { customFont(.bold, fontSize: 56) } // Largest headline
    static var headline2: Font { customFont(.bold, fontSize: 40) }
    static var headline3: Font { customFont(.bold, fontSize: 32) }
    static var headline4: Font { customFont(.bold, fontSize: 24) }
    static var headline5: Font { customFont(.bold, fontSize: 20) }
    static var headline6: Font { customFont(.semibold, fontSize: 16) }
    static var headline7: Font { customFont(.semibold, fontSize: 14) }
    static var headline8: Font { customFont(.semibold, fontSize: 12) } // Smallest headline
    
    // Body Styles
    static var bodyLarge: Font { customFont(.regular, fontSize: 16) }
    static var bodyMedium: Font { customFont(.regular, fontSize: 14) }
    static var bodySmall: Font { customFont(.medium, fontSize: 12) }
    static var bodySmall2: Font { customFont(.medium, fontSize: 10) }
    
    
    // Subtitle Style
    static var subtitle: Font { customFont(.medium, fontSize: 20) }
}
