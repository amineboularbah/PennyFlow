//
//  ContentView.swift
//  pennyflow
//
//  Created by Amine on 7/12/2024.
//

import SwiftUI

struct SubscriptionsGridView: View {
    @EnvironmentObject var subscriptionData: SubscriptionsViewModel
    @Binding var selectedPlatform: Subscription? // Track selected subscription ID
    @State private var showAllSubscriptions = false
    @State private var topSubscriptions: [Subscription] = []

    var body: some View {
        VStack {
            Spacer().frame(height: .topInsets)
            HStack {
                Text("Top Subscriptions")
                    .appTextStyle(font: .headline5)

                Spacer()

                Button(action: {
                    showAllSubscriptions = true
                }) {
                    Text("See All")
                        .appTextStyle(font: .bodyMedium, color: .gray30)
                }
            }

            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 100), spacing: 20)],
                spacing: 20
            ) {
                ForEach(topSubscriptions, id: \.id) { subscription in
                    VStack {
                        SubscriptionImageView(
                            imageName: subscription.icon ?? "",
                            subscriptionTitle: subscription.name ?? "",
                            imageSize: 70
                        )

                        Text(subscription.name ?? "")
                            .appTextStyle(font: .bodyLarge)
                            .lineLimit(1)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(
                                selectedPlatform?.id == subscription.id
                                    ? .secondaryC
                                    : Color.clear,
                                lineWidth: 3
                            )
                    )
                    .onTapGesture {
                        selectedPlatform?.id = subscription.id
                        print("Selected subscription: \(subscription.name ?? "")")
                    }
                }
            }
            .onAppear {
                if topSubscriptions.isEmpty {
                    topSubscriptions = Array(subscriptionData.subscriptions.prefix(6))
                }
            }
            .sheet(isPresented: $showAllSubscriptions) {
                AllSubscriptionsView(
                    selectedPlatform: $selectedPlatform, // Convert Int? to String? and back
                    onSelect: { subscription in
                        updateTopSubscriptions(with: subscription?.id)
                    }
                )
                .environmentObject(subscriptionData)
            }
        }
        .padding()
        .background(
            BottomRoundedRectangle(cornerRadius: 40)
                .fill(Color.gray70)
        )
    }

    private func updateTopSubscriptions(with subscription: UUID?) {
        guard let subscription = subscription,
              let selectedSubscription = subscriptionData.subscriptions.first(where: {
                  if let id = $0.id {
                      return  id == subscription
                  }
                  return false
              })        else { return }

        if !topSubscriptions.contains(where: { $0.id == selectedSubscription.id }) {
            if topSubscriptions.count < 6 {
                topSubscriptions.append(selectedSubscription)
            } else {
                topSubscriptions[topSubscriptions.count - 1] = selectedSubscription
            }
        }
    }
}
