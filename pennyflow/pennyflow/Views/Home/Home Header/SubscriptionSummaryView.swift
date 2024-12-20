//
//  SubscriptionSummaryView.swift
//  pennyflow
//
//  Created by Amine on 8/12/2024.
//


import SwiftUI

struct SubscriptionSummaryView: View {
    @EnvironmentObject var viewModel: SubscriptionsViewModel
    var body: some View {
        HStack(spacing: 16) {
            // Active Subs Card
            SummaryCard(
                title: "Active subs",
                value: "\(viewModel.userSubscriptions.count)",
                indicatorColor: .secondary50
            )

            // Highest Subs Card
            SummaryCard(
                title: "Highest subs",
                value: viewModel.getHighestSubscription(),
                indicatorColor: .primary10,
                isSelected: true // Highlighted card
            )

            // Lowest Subs Card
            SummaryCard(
                title: "Lowest subs",
                value: viewModel.getLowestSubscription(),
                indicatorColor: .secondaryG50
            )
        }
    }
}

struct SummaryCard: View {
    let title: String
    let value: String
    let indicatorColor: Color
    let isSelected: Bool

    init(title: String, value: String, indicatorColor: Color, isSelected: Bool = false) {
        self.title = title
        self.value = value
        self.indicatorColor = indicatorColor
        self.isSelected = isSelected
    }

    var body: some View {
        ZStack(alignment: .top) {
            // Card Background
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray.opacity(0.2))
                .overlay(
                    // Highlighted Border for Selected Card
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.clear, lineWidth: 2)
                )

            // Top Indicator
            RoundedRectangle(cornerRadius: 2)
                .fill(indicatorColor)
                .frame(width: 46, height: 1)
                .padding(.top, 0)

            VStack(spacing: 8) {
                // Title
                Text(title)
                    .appTextStyle(font: .headline8, color: .gray40)

                // Value
                Text(value)
                    .appTextStyle(font: .headline7)
            }
            .frame(width: 100, height: 70)
            .multilineTextAlignment(.center)
           
        }
        .frame(width: 100, height: 68) // Adjust the card size as needed
    }
}

struct SubscriptionSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionSummaryView().applyDefaultBackground()
    }
}
