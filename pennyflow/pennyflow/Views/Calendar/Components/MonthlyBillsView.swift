//
//  MonthlyBillsView.swift
//  pennyflow
//
//  Created by Amine on 13/12/2024.
//


import SwiftUI

struct CalendarMonthlyBillsView: View {
    @ObservedObject var viewModel: CalendarViewModel // Pass the ViewModel to access data

    var body: some View {
        HStack {
            // Month and Date
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.selectedMonth)
                    .font(.title2).bold()
                    .foregroundColor(.white)
                Text(currentDateFormatted()) // Display today's date
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Total Bills
            VStack(alignment: .trailing, spacing: 4) {
                Text("$\(String(format: "%.2f", totalUpcomingBills()))") // Sum of all subscription prices
                    .font(.headline).bold()
                    .foregroundColor(.white)
                Text("in upcoming bills")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2)) // Background container
        .clipShape(RoundedRectangle(cornerRadius: 15)) // Rounded edges
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
        return dateFormatter.string(from: Date())
    }
}
