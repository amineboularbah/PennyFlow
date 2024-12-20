//
//  AllSubscriptionsView.swift
//  pennyflow
//
//  Created by Amine on 7/12/2024.
//
import SwiftUI

// MARK: - All Subscriptions View
/// Displays a list of platforms, allowing the user to select one and pass it back to the parent view.
struct AllPlatformsView: View {
    // MARK: Properties
    @EnvironmentObject var viewModel: PlatformViewModel // Environment object for platforms
    @Binding var selectedPlatform: Platform?  // Binding to track selected platform
    var onSelect: (Platform?) -> Void  // Callback to handle selection
    @Environment(\.dismiss) private var dismiss  // Environment property to dismiss the sheet

    // MARK: Body
    var body: some View {
        NavigationView {
            ScrollView {
                // MARK: LazyVStack for platform Rows
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.platforms, id: \.id) { platform in
                        PlatformRow(
                            platform: platform,
                            isSelected: selectedPlatform == platform
                        ) {
                            selectedPlatform = platform
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("All platforms")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // MARK: Done Button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        onSelect(selectedPlatform)
                        dismiss()
                    }
                }
            }
        }
        .applyDefaultBackground()
    }
}

// MARK: - Platform Row
/// Represents a single row in the platforms list, displaying platform details and selection status.
struct PlatformRow: View {
    // MARK: Properties
    let platform: Platform
    let isSelected: Bool
    let onTap: () -> Void

    // MARK: Body
    var body: some View {
        HStack {
            // MARK: Icon/Image
            SubscriptionImageView(
                imageName: platform.image ?? "",
                subscriptionTitle: platform.name ?? "",
                imageSize: 60
            )

            // MARK: Name and Description
            VStack(alignment: .leading) {
                Text(platform.name ?? "Unknown")
                    .font(.headline)
                Text(platform.desc ?? "No description available")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }

            Spacer()

            // MARK: Selection Indicator
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.white)
            }
        }
        .contentShape(Rectangle())  // Makes the entire row tappable
        .padding(.horizontal)
        .padding(.vertical, 8)
        .onTapGesture {
            onTap()
        }
    }
}
