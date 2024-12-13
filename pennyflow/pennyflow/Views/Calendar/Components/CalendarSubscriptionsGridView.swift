//
//  CalendarSubscriptionsGridView.swift
//  pennyflow
//
//  Created by Amine on 13/12/2024.
//


import SwiftUI

struct CalendarSubscriptionsGridView: View {
    @ObservedObject var viewModel: CalendarViewModel // Pass the ViewModel to access subscriptions

    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            ForEach(viewModel.subscriptions) { subscription in
                SubscriptionCard(subscription: subscription)
            }
        }
        .padding(.top, 16)
    }
}

// MARK: - Subscription Card Component
struct SubscriptionCard: View {
    let subscription: Subscription

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Subscription Logo
            Image(subscription.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 50)
            
            // Subscription Name
            Text(subscription.name)
                .font(.headline)
                .foregroundColor(.white)
            
            // Subscription Price
            if let price = subscription.price {
                Text("$\(String(format: "%.2f", price))")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            } else {
                Text("No price")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2)) // Card background
        .clipShape(RoundedRectangle(cornerRadius: 15)) // Rounded corners
    }
}
