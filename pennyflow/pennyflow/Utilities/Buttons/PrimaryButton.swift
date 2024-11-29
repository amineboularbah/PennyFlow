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
    var gradientColors: [Color] = [.secondary50, .secondaryC]
    
    var body: some View {
        GeometryReader { geometry in
            Button(action: action) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 50)
                            .fill(
                                RadialGradient(
                                    gradient: Gradient(colors: gradientColors),
                                    center: .center,
                                    startRadius: 0,
                                    endRadius: geometry.size.height / 2 // 50% of height
                                )
                            )
                            .shadow(
                                color: gradientColors.first ?? .secondary50,
                                radius: 15, x: 0, y: 5
                            )
                    )
            }
            .scaleEffectOnPress()
        }
        .frame(height: 50) // Set a fixed height for the button
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
        .background(Color.black.edgesIgnoringSafeArea(.all)) // Dark background for contrast
    }
}
