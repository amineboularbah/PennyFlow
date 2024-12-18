//
//  AllSubscriptionsView.swift
//  pennyflow
//
//  Created by Amine on 7/12/2024.
//
import SwiftUI

// MARK: - All Subscriptions View
/// Displays a list of subscriptions, allowing the user to select one and pass it back to the parent view.
struct AllSubscriptionsView: View {
    // MARK: Properties
    @EnvironmentObject var subscriptionData: SubscriptionsViewModel // Environment object for subscriptions
    @Binding var selectedPlatform: Subscription?  // Binding to track selected subscription
    var onSelect: (Subscription?) -> Void  // Callback to handle selection
    @Environment(\.dismiss) private var dismiss  // Environment property to dismiss the sheet

    // MARK: Body
    var body: some View {
        NavigationView {
            ScrollView {
                // MARK: LazyVStack for Subscription Rows
                LazyVStack(spacing: 16) {
                    ForEach(subscriptionData.subscriptions, id: \.id) { subscription in
                        SubscriptionRow(
                            subscription: subscription,
                            isSelected: selectedPlatform?.id == subscription.id
                        ) {
                            selectedPlatform = subscription
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("All Subscriptions")
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

// MARK: - Subscription Row
/// Represents a single row in the subscriptions list, displaying subscription details and selection status.
struct SubscriptionRow: View {
    // MARK: Properties
    let subscription: Subscription
    let isSelected: Bool
    let onTap: () -> Void

    // MARK: Body
    var body: some View {
        HStack {
            // MARK: Icon/Image
            SubscriptionImageView(
                imageName: subscription.icon ?? "",
                subscriptionTitle: subscription.name ?? "",
                imageSize: 60
            )

            // MARK: Name and Description
            VStack(alignment: .leading) {
                Text(subscription.name ?? "Unknown")
                    .font(.headline)
                Text(subscription.desc ?? "No description available")
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
