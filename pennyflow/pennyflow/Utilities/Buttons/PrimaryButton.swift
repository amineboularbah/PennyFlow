//
//  PrimaryButton.swift
//  pennyflow
//
//  Created by Amine on 29/11/2024.
//

import SwiftUI

struct PrimaryButton: View {
    var title: String
    var action: () -> Void
    var gradientColors: [Color] = [.secondaryC, .secondaryC]
    var isEnabled: Bool = true // Enabled by default

    var body: some View {
        GeometryReader { geometry in
            Button(action: {
                if isEnabled {
                    action()
                }
            }) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(isEnabled ? .white : .white) // Adjust text color for disabled state
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 50)
                            .strokeBorder(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.white.opacity(isEnabled ? 0.15 : 0.05), // Dim for disabled
                                        Color.white.opacity(isEnabled ? 0.5 : 0.1)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )
                            .fill(
                                RadialGradient(
                                    gradient: Gradient(colors: isEnabled ? gradientColors : [.gray, .gray]),
                                    center: .center,
                                    startRadius: 0,
                                    endRadius: geometry.size.height / 2
                                )
                            )
                            .shadow(
                                color: isEnabled ? (gradientColors.first ?? .secondary50) : .clear,
                                radius: isEnabled ? 15 : 0, x: 0, y: 5
                            )
                    )
            }
            .scaleEffectOnPress()
            .disabled(!isEnabled) // Disable interaction
        }
        .frame(height: 50) // Fixed height
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            PrimaryButton(title: "Get Started") {
                print("Button Pressed!")
            }
            
            PrimaryButton(
                title: "Learn More",
                action:  {
                    print("Learn More Button Pressed!")
                }, gradientColors: [.secondaryC, .secondaryC])
        }
        .padding()
    }
}
