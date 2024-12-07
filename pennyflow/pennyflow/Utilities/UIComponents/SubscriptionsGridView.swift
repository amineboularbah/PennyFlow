//
//  ContentView.swift
//  pennyflow
//
//  Created by Amine on 7/12/2024.
//

import SwiftUI

struct SubscriptionsGridView: View {
    @EnvironmentObject var subscriptionData: SubscriptionData  // Access via environment
    @Binding var selectedPlatform: Int?  // Track selected subscription ID
    @State private var showAllSubscriptions = false  // Show the "See All" list
    @State private var topSubscriptions: [Subscription] = []  // Top 6 subscriptions
    var body: some View {
        VStack {

            HStack {
                Text("Top Subscriptions")
                    .appTextStyle(font: .headline4)

                Spacer()

                Button(action: {
                    showAllSubscriptions = true
                }) {
                    Text("See All")
                        .appTextStyle(font: .bodyMedium, color: .gray30)
                }
            }

            ScrollView {
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: 100), spacing: 20)],
                    spacing: 20
                ) {
                    ForEach(topSubscriptions) { subscription in
                        VStack {
                            SubscriptionImageView(
                                imageName: subscription.image,
                                subscriptionTitle: subscription.name,
                                imageSize: 70
                            )

                            Text(subscription.name)
                                .appTextStyle(font: .bodyLarge)
                                .lineLimit(1)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)  // Add the border shape
                                .stroke(
                                    selectedPlatform == subscription.id
                                        ? .secondaryC : Color.clear,  // Orange border for selected
                                    lineWidth: 3
                                )
                        )
                        .onTapGesture {
                            selectedPlatform = subscription.id
                            print("Selected items is: \(subscription.id)")
                        }

                    }
                }
                .onAppear {
                    // Initialize top subscriptions on first render
                    if topSubscriptions.isEmpty {
                        topSubscriptions = Array(
                            subscriptionData.subscriptions.prefix(6))
                    }
                }
                .sheet(isPresented: $showAllSubscriptions) {
                            AllSubscriptionsView(selectedPlatform: $selectedPlatform) { selectedID in
                                updateTopSubscriptions(with: selectedID)
                            }
                            .environmentObject(subscriptionData)
                        }
            }.padding(.top)

        }.padding()
    }
    
    // Logic to Update Top Subscriptions
    private func updateTopSubscriptions(with selectedID: Int?) {
        guard let selectedID = selectedID,
              let selectedSubscription = subscriptionData.subscriptions.first(where: { $0.id == selectedID }) else {
            return
        }

        if !topSubscriptions.contains(where: { $0.id == selectedID }) {
            if topSubscriptions.count < 6 {
                // Add the new subscription if there's room
                topSubscriptions.append(selectedSubscription)
            } else {
                // Replace the last item if top 6 is full
                topSubscriptions[topSubscriptions.count - 1] = selectedSubscription
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let mockSubscriptionData = SubscriptionData()  // Initialize mock data

        SubscriptionsGridView(selectedPlatform: .constant(nil))
            .environmentObject(mockSubscriptionData)  // Inject into the preview
            .applyDefaultBackground()
    }
}
