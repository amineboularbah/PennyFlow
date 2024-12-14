//
//  GradientLayer.swift
//  pennyflow
//
//  Created by Amine on 14/12/2024.
//

import SwiftUI

struct GradientLayer: View {
    var body: some View {
        VStack {
            Spacer()
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.gray80, Color.gray80, Color.gray80.opacity(0),
                ]),
                startPoint: .bottom,
                endPoint: .top
            )
            .frame(height: 120)   // Completely ignore the bottom safe area
        }
    }
}
