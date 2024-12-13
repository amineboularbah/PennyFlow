//
//  MonthlyBillsView.swift
//  pennyflow
//
//  Created by Amine on 13/12/2024.
//

import SwiftUI

struct CalendarMonthlyBillsView: View {
    @ObservedObject var viewModel: CalendarViewModel  // Pass the ViewModel to access data

    var body: some View {
        HStack {
            // Month and Date
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.selectedMonth)
                    .appTextStyle(font: .headline5)
                Text(currentDateFormatted())  // Display today's date
                    .appTextStyle(font: .bodySmall, color: .gray30)
            }

            Spacer()

            // Total Bills
            VStack(alignment: .trailing, spacing: 4) {
                Text("$\(String(format: "%.2f", totalUpcomingBills()))")  // Sum of all subscription prices
                    .appTextStyle(font: .headline5)
                Text("in upcoming bills")
                    .appTextStyle(font: .bodySmall, color: .gray30)
            }
        }
    }

    // MARK: - Helper Functions

    /// Calculates the total upcoming bills for the month
    private func totalUpcomingBills() -> Double {
        viewModel.subscriptions.reduce(0) { $0 + ($1.price ?? 0) }
    }

    /// Formats today's date (e.g., "01.08.2024")
    private func currentDateFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd.yyyy"
        return dateFormatter.string(from: viewModel.selectedDate)
    }
}
