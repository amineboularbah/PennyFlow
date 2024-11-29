//
//  TextViewModifier.swift
//  pennyflow
//
//  Created by Amine on 29/11/2024.
//
import SwiftUI

struct AppTextStyle: ViewModifier {
    var font: Font
    var color: Color = .white // Default to white text

    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(color)
    }
}

extension View {
    func appTextStyle(font: Font, color: Color = .white) -> some View {
        self.modifier(AppTextStyle(font: font, color: color))
    }
}
