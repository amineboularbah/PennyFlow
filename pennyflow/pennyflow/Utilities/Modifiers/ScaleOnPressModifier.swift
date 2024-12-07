//
//  ScaleOnPressModifier.swift
//  pennyflow
//
//  Created by Amine on 29/11/2024.
//

import SwiftUI

struct ScaleOnPressModifier: ViewModifier {
    @State private var isPressed = false
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: isPressed)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in isPressed = true }
                    .onEnded { _ in isPressed = false }
            )
    }
}

extension View {
    func scaleEffectOnPress() -> some View {
        self.modifier(ScaleOnPressModifier())
    }
}
