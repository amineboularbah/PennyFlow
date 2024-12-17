//
//  AllSubscriptionsView.swift
//  pennyflow
//
//  Created by Amine on 7/12/2024.
//

import SwiftUI

struct AllSubscriptionsView: View {
    @EnvironmentObject var subscriptionData: SubscriptionsViewModel // Environment object for subscriptions
    @Binding var selectedPlatform: UUID?  // Binding to track selected subscription
    var onSelect: (UUID?) -> Void  // Callback to handle selection
    @Environment(\.dismiss) private var dismiss  // Environment property to dismiss the sheet

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(subscriptionData.subscriptions, id: \.id) { subscription in
                        HStack {
                            // Icon/Image
                            SubscriptionImageView(
                                imageName: subscription.icon ?? "",
                                subscriptionTitle: subscription.name ?? "",
                                imageSize: 60
                            )

                            // Name and Description
                            VStack(alignment: .leading) {
                                Text(subscription.name ?? "Unknown")
                                    .font(.headline)
                                Text(subscription.desc ?? "No description available")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .lineLimit(2)
                            }

                            Spacer()

                            // Checkmark for selected item
                            if selectedPlatform == subscription.id {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.white)
                            }
                        }
                        .contentShape(Rectangle())  // Makes the entire row tappable
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .onTapGesture {
                            selectedPlatform = subscription.id  // Set as selected platform
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("All Subscriptions")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Done button to close the sheet
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        // Pass selected ID to parent and close the sheet
                        onSelect(selectedPlatform)
                        dismiss()
                    }
                }
            }
        }
        .applyDefaultBackground()
    }
}

// MARK: - Preview
struct AllSubscriptionsView_Previews: PreviewProvider {
    static var previews: some View {
        // Create an in-memory Core Data context for the preview
        let context = PersistenceController.preview.container.viewContext
        let mockViewModel = SubscriptionsViewModel(context: context,currentUser: nil)

        // Populate mock subscriptions for preview
        let mockSubscriptions = [
            SubscriptionDTO(
                id: UUID(),
                name: "Spotify",
                price: 9.99,
                icon: "spotify_logo",
                desc: "Music App",
                startDate: Date(),
                reminder: nil,
                categoryName: "Entertainment",
                dueDate: Calendar.current.date(byAdding: .month,value: 1,  to: Date())
            ),
            SubscriptionDTO(
                id: UUID(),
                name: "Netflix",
                price: 15.99,
                icon: "netflix_logo",
                desc: "Video Streaming",
                startDate: Date(),
                reminder: nil,
                categoryName: "Entertainment",
                dueDate: Calendar.current.date(byAdding: .year,value: 1,  to: Date())
            )
        ]

        for dto in mockSubscriptions {
            mockViewModel.addSubscription(from: dto)
        }

        // Return the view for preview
        return AllSubscriptionsView(
            selectedPlatform: .constant(mockSubscriptions.first?.id),
            onSelect: { selectedID in
                print("Selected platform ID in preview: \(String(describing: selectedID))")
            }
        )
        .applyDefaultBackground()
        .environmentObject(mockViewModel)  // Inject mock view model
    }
}
