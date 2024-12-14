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
    var cornerRadius: Double?
    var width: Double?
    var isFilled: Bool?
    var textColor: Color?
    var suffixIcon: String?

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .appTextStyle(font: .headline8, color: textColor ?? .white)

                if let _ = suffixIcon {
                    Image(suffixIcon ?? "")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .tint(.white)
                }
            }
            .padding(12)
            .frame(maxWidth: width ?? .infinity)  // Full-width button
            .background(
                RoundedRectangle(cornerRadius: cornerRadius ?? 50)
                    .fill(
                        isFilled == true
                            ? .white.opacity(0.1) : Color.clear
                    )
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                isFilled == true
                                    ? Color.white.opacity(0.2)
                                    : Color.clear,  // 15% opacity
                                isFilled == true
                                    ? Color.white.opacity(0)
                                    : Color.clear  // 10% opacity,,
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1  // Stroke thickness
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
        .background(Color.black.edgesIgnoringSafeArea(.all))  // Dark background for contrast
    }
}
