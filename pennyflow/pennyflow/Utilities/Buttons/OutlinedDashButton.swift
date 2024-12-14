//
//  OutlinedDashButton.swift
//  pennyflow
//
//  Created by Amine on 14/12/2024.
//
import SwiftUI

struct OutlinedDashButton: View {
    let title: String
    let onTap: () -> Void
    var body: some View {
        Button(action: {
            print("Add new category tapped")
            onTap()
        }) {
            HStack {
                Spacer()  // Push content to the center
                Text(title)
                    .appTextStyle(font: .headline7, color: .gray30)
                Image("add")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 16, height: 16)
                    .foregroundColor(.gray30)
                Spacer()  // Push content to the center
            }
            .frame(height: 64)  // Set the inner content height
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(
                        Color.gray60,
                        style: StrokeStyle(
                            lineWidth: 1,
                            dash: [6]
                        ))
            )
        }
        .padding(.horizontal)  // Adds padding on the sides

        .frame(height: 84)
    }
}
