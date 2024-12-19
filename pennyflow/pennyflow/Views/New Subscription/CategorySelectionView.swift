import SDWebImageSwiftUI
//
//  CategorySelectionView.swift
//  pennyflow
//
//  Created by Amine on 18/12/2024.
//
import SwiftUI

struct CategorySelectionView: View {
    @Binding var selectedCategory: Category?
    @Environment(\.presentationMode) var presentationMode

    @Environment(\.managedObjectContext) var context
    @State private var categories: [Category] = []
    @EnvironmentObject var categoryViewModel: CategoryViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(categoryViewModel.categories) { category in
                        CategoryRow(
                            category: category,
                            isSelected: selectedCategory == category,
                            onTap: {
                                selectedCategory = category
                                presentationMode.wrappedValue.dismiss()
                            })
                    }
                }
            }.padding()
                .navigationTitle("Select Category")
                .navigationBarTitleDisplayMode(.inline)
                
        }.applyDefaultBackground()
    }

}

// MARK: Category view row
struct CategoryRow: View {
    let category: Category
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: {
          onTap()
        }) {
            HStack {
                showCategoryImage(for: category)

                // Category Info
                VStack(alignment: .leading, spacing: 4) {
                    Text(category.name ?? "")
                        .appTextStyle(font: .headline7)
                    Text("$\(category.remainingAmount.formatted()) left to spend")
                        .appTextStyle(font: .bodySmall, color: .gray30)
                }
                Spacer()

                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                }
            }
            .contentShape(Rectangle()) // Optional but ensures the entire area is tappable
            .padding()
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
        .buttonStyle(PlainButtonStyle()) // Removes the default button appearance


    }

    private func showCategoryImage(for category: Category) -> some View {
        Group {

            // Icon
            if let url = URL(string: category.image ?? ""),
                UIApplication.shared.canOpenURL(url)
            {
                // Load image from URL with caching
                WebImage(url: url) { image in
                    image.resizable()  // Control layout like SwiftUI.AsyncImage, you must use this modifier or the view will use the image bitmap size
                } placeholder: {
                    Rectangle().foregroundColor(.gray)
                }
                // Supports options and context, like `.delayPlaceholder` to show placeholder only when error
                .onSuccess { image, data, cacheType in
                    // Success
                    // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
                }
                .indicator(.activity)  // Activity Indicator
                .transition(.fade(duration: 0.5))  // Fade Transition with duration
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
