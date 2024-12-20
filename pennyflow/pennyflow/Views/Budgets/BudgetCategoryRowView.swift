//
//  BudgetCategoryRowView.swift
//  pennyflow
//
//  Created by Amine on 9/12/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct BudgetCategoryRowView: View {
    var category: Category

    var body: some View {
        VStack {
            HStack {
                showCategoryImage()

                // Category Info
                VStack(alignment: .leading, spacing: 4) {
                    Text(category.name ?? "")
                        .appTextStyle(font: .headline7)
                    Text("$\(category.remainingAmount.formatted()) left to spend")
                        .appTextStyle(font: .bodySmall, color: .gray30)
                }
                Spacer()

                // Amount Spent
                VStack {
                    Text("$\(category.totalAmountSpent.formatted())")
                        .appTextStyle(font: .headline7)
                    Text("of $\(String(describing: category.budget.formatted()))")
                        .appTextStyle(font: .bodySmall, color: .gray30)
                }
            }
            Spacer().frame(height: 10)
            ZStack(alignment: .leading) {
                GeometryReader { geometry in
                    // Background track
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gray60)
                        .frame(height: 4)  // Adjust height for better visibility

                    // Progress bar
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(hex: category.color ?? "FFFFFF"))
                        .frame(
                            width: geometry.size.width * CGFloat(category.progress), // Scale width dynamically
                            height: 4  // Match the background height
                        )
                }
                .frame(height: 4) // Ensure the ZStack has a fixed height
            }        }.padding()
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
    private func showCategoryImage() -> some View {
        Group{
            
            // Icon
            if let url = URL(string: category.image ?? ""), UIApplication.shared.canOpenURL(url) {
                // Load image from URL with caching
                WebImage(url: url) { image in
                    image.resizable() // Control layout like SwiftUI.AsyncImage, you must use this modifier or the view will use the image bitmap size
                } placeholder: {
                        Rectangle().foregroundColor(.gray)
                }
                // Supports options and context, like `.delayPlaceholder` to show placeholder only when error
                .onSuccess { image, data, cacheType in
                    // Success
                    // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
                }
                .indicator(.activity) // Activity Indicator
                .transition(.fade(duration: 0.5)) // Fade Transition with duration
                .scaledToFit()
                .frame(width: 32, height: 32, alignment: .center)
            } else {
                // Load image from local assets
                Image(category.image ?? "")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .scaledToFit()
                    .foregroundColor(.gray30)
            }
        }
    }
}
