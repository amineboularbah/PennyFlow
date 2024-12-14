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
        ScrollView{
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 0) {
                ForEach(viewModel.subscriptions) { subscription in
                    SubscriptionCard(subscription: subscription)
                }
            }
            .padding(.top, 16)
        }
        .frame(maxHeight: .infinity)
    }
}

// MARK: - Subscription Card Component
struct SubscriptionCard: View {
    let subscription: Subscription

    var body: some View {
        GeometryReader { geometry in
            HStack{
                VStack(alignment: .leading, spacing: 8) {
                    // Subscription Logo
                    Image(subscription.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: CalendarStyles.iconSize) // Adjust logo height based on card height
                    Spacer()
                    // Subscription Name
                    Text(subscription.name)
                        .appTextStyle(font: .headline7)

                    // Subscription Price
                    if let price = subscription.price {
                        Text("$\(String(format: "%.2f", price))")
                            .appTextStyle(font: .headline5)
                    } else {
                        Text("No price")
                            .appTextStyle(font: .headline5)
                    }
                }
                Spacer()
            }
            .padding()
            .frame(maxWidth: 160, maxHeight: 168) // Full size
            .background(Color.gray30.opacity(0.2)) // Card background
            .clipShape(RoundedRectangle(cornerRadius: CalendarStyles.cornerRadius)) // Rounded corners
        }
       
        .aspectRatio(4 / 4, contentMode: .fill) // Ensures cards maintain a consistent aspect ratio
    }
}
