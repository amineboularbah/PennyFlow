import SwiftUI

struct AllSubscriptionsView: View {
    let subscriptions: [Subscription] // List of all subscriptions
    @Binding var selectedPlatform: Int? // Binding to track selected subscription

    var body: some View {
        NavigationView {
            List(subscriptions) { subscription in
                HStack {
                    // Icon/Image
                    AsyncImage(url: URL(string: subscription.image)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    } placeholder: {
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 50, height: 50)
                    }

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
                            .foregroundColor(.orange)
                    }
                }
                .contentShape(Rectangle()) // Makes the entire row tappable
                .onTapGesture {
                    selectedPlatform = subscription.id // Set as selected platform
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("All Subscriptions") // Title for the navigation view
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Done button to close the sheet
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        // Logic to close the sheet (handled by parent view)
                    }
                }
            }
        }
    }
}