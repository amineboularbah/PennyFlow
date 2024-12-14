//
//  AllSubscriptionsView.swift
//  pennyflow
//
//  Created by Amine on 7/12/2024.
//

import SwiftUI

struct AllSubscriptionsView: View {
    @EnvironmentObject var subscriptionData: SubscriptionsViewModel // Environment object for subscriptions
    @Binding var selectedPlatform: String?  // Binding to track selected subscription
    var onSelect: (Int?) -> Void  // Callback to handle selection
    @Environment(\.dismiss) private var dismiss  // Environment property to dismiss the sheet
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(subscriptionData.subscriptions) { subscription in
                        HStack {
                            // Icon/Image
                            SubscriptionImageView(
                                imageName: subscription.image,
                                subscriptionTitle: subscription.name,
                                imageSize: 60
                            )

                            // Name and Description
                            VStack(alignment: .leading) {
                                Text(subscription.name)
                                    .font(.headline)
                                Text(subscription.description)
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
                        // Logic to close the sheet (handled by parent view)
                        onSelect(selectedPlatform)  // Pass selected ID to parent
                        // we should dismiss the bottom sheet
                        dismiss()
                    }
                }
            }
        }.applyDefaultBackground()
    }
}

struct AllSubscriptionsView_Previews: PreviewProvider {
    static var previews: some View {
        // Create an in-memory Core Data context for the preview
        let context = PersistenceController.preview.container.viewContext
        let mockViewModel = SubscriptionsViewModel(context: context)

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
                categoryName: "Entertainment"
            ),
            SubscriptionDTO(
                id: UUID(),
                name: "Netflix",
                price: 15.99,
                icon: "netflix_logo",
                desc: "Video Streaming",
                startDate: Date(),
                reminder: nil,
                categoryName: "Entertainment"
            )
        ]

        for dto in mockSubscriptions {
            mockViewModel.addSubscription(from: dto)
        }

        // Return the view for preview
        return AllSubscriptionsView(
            selectedPlatform: .constant(2),
            onSelect: { selectedID in
                print("Selected platform ID in preview: \(String(describing: selectedID))")
            }
        )
        .applyDefaultBackground()
        .environmentObject(mockViewModel)  // Inject mock view model
    }
}
