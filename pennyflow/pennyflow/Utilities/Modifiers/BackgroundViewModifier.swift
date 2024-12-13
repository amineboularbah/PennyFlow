//
//  BackgroundViewModifier.swift
//  pennyflow
//
//  Created by Amine on 29/11/2024.
//

import SwiftUI

struct DefaultBackgroundModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .background(Color.gray80.edgesIgnoringSafeArea(.all)) // Apply color to the entire screen
    }
}

extension View {
    func applyDefaultBackground() -> some View {
        self.modifier(DefaultBackgroundModifier())
    }
}
