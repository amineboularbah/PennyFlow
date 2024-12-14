//
//  SubscriptionRowView.swift
//  pennyflow
//
//  Created by Amine on 8/12/2024.
//

import SwiftUI

struct SubscriptionRowView: View {
    let subscription: Subscription
    let showDate: Bool
    @State private var navigateToSettings = false

    var body: some View {
        NavigationStack {
            HStack(spacing: 16) {
                // Subscription Image
                Image(subscription.icon ?? "pennyflow")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                VStack(alignment: .leading, spacing: 4) {
                    // Subscription Name
                    Text(subscription.name ?? "Penny Flow")
                        .font(.headline)
                        .foregroundColor(.white)

                    // Optional Description
                    if !subscription.description.isEmpty {
                        Text(subscription.description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .lineLimit(1)
                    }
                }

                Spacer()

                // Price or Date + Price
                if showDate {
                    VStack(alignment: .trailing, spacing: 4) {
                        Text(subscription.startDate?.formattedDate() ?? "")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        Text(
                            "$\(String(format: "%.2f", subscription.price))"
                        )
                        .font(.headline)
                        .foregroundColor(.white)
                    }
                } else {
                    Text("$\(String(format: "%.2f", subscription.price ))")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
            .onTapGesture {
                navigateToSettings = true
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Color.gray70, lineWidth: 1)
            ).navigationDestination(isPresented: $navigateToSettings) {
                SubscriptionInfoView(subscription:  subscription)
            }
        }
    }
}

struct SubscriptionRowView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionRowView(
            subscription:
                Subscription(),
            showDate: true
        )
        .padding()
        .background(Color.black)
    }
}
