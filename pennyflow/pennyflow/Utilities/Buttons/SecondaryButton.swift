//
//  SecondaryButton.swift
//  pennyflow
//
//  Created by Amine on 29/11/2024.
//

import SwiftUI

struct SecondaryButton: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white) // Text color
                .padding()
                .frame(maxWidth: .infinity) // Full-width button
                .background(
                    RoundedRectangle(cornerRadius: 50)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(0.15), // 15% opacity
                                    Color.white.opacity(0.10)  // 10% opacity
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .strokeBorder(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(0.15), // 15% opacity
                                    Color.white.opacity(0.10)  // 10% opacity
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1 // Stroke thickness
                        )
                )
        }
    }
}

struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            SecondaryButton(title: "Secondary Button") {
                print("Secondary Button Pressed!")
            }
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all)) // Dark background for contrast
    }
}
