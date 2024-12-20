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
    let dueDate: Date?
    @State private var navigateToSettings = false

    var body: some View {
        NavigationStack {
            HStack(spacing: 16) {
                // Subscription Image
                Group {
                    if dueDate != nil {
                        // Show a square box with text if dueDate is nil
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray70)
                            .frame(width: 40, height: 40)
                            .overlay(
                                VStack {
                                    Text(getMonthAbbreviation(from: dueDate!))
                                        .appTextStyle(
                                            font: .bodySmall2, color: .gray30)

                                    Text("\(getDayNumber(from: dueDate!))")
                                        .appTextStyle(
                                            font: .headline7, color: .gray30)
                                }.padding(4)
                            )
                    } else {
                        // Show the image if dueDate is not nil
                        Image(subscription.icon ?? "placeholder")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                // Subscription Name
                Text(subscription.name ?? "Penny Flow")
                    .font(.headline)
                    .foregroundColor(.white)

                Spacer()

                // Price or Date + Price
                if showDate {

                    Text(
                        "$\(String(format: "%.2f", subscription.price))"
                    )
                    .font(.headline)
                    .foregroundColor(.white)
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
                SubscriptionInfoView(subscription: subscription)
            }
        }

    }
    func getMonthAbbreviation(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"  // Abbreviated month name
        return dateFormatter.string(from: date)  // e.g., "Dec"
    }

    func getDayNumber(from date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: date)  // Extracts the day component
    }
}

struct SubscriptionRowView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionRowView(
            subscription:
                Subscription(),
            showDate: true,
            dueDate: nil
        )
        .padding()
        .background(Color.black)
    }
}
