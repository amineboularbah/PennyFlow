//
//  BackgroundViewModifier.swift
//  pennyflow
//
//  Created by Amine on 29/11/2024.
//

import SwiftUI

struct DefaultBackgroundModifier: ViewModifier {
    var color: Color = .gray80 // Default background color

    func body(content: Content) -> some View {
        content
            .background(color.edgesIgnoringSafeArea(.all)) // Apply color to the entire screen
    }
}

extension View {
    func applyDefaultBackground(_ color: Color = .gray80) -> some View {
        self.modifier(DefaultBackgroundModifier(color: color))
    }
}
