//
//  BudgetCategoryRowView.swift
//  pennyflow
//
//  Created by Amine on 9/12/2024.
//

import SwiftUI

struct BudgetCategoryRowView: View {
    var category: BudgetCategory

    var body: some View {
        VStack {
            HStack {
                // Icon
                Image(category.icon)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundColor(.gray30)

                // Category Info
                VStack(alignment: .leading, spacing: 4) {
                    Text(category.name)
                        .appTextStyle(font: .headline7)
                    Text(category.remainingText)
                        .appTextStyle(font: .bodySmall, color: .gray30)
                }
                Spacer()

                // Amount Spent
                VStack {
                    Text(category.spentText)
                        .appTextStyle(font: .headline7)
                    Text(category.totalText)
                        .appTextStyle(font: .bodySmall, color: .gray30)
                }
            }
            Spacer().frame(height: 10)
            ZStack(alignment: .leading) {
                // Background track
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray60)
                    .frame(height: 4) // Adjust height for better visibility

                // Progress bar
                RoundedRectangle(cornerRadius: 16)
                    .fill(category.progressColor)
                    .frame(
                        width: CGFloat(category.progress) * UIScreen.main.bounds.width * 0.8, // Adjust width to fit layout
                        height: 4 // Match the background height
                    )
            }
        }.padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray60.opacity(0.2))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.white.opacity(0.1),  // 15% opacity
                                Color.white.opacity(0),  // 10% opacity,
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1  // Stroke thickness
                    )
            )

    }
}
