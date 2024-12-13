//
//  HeaderView.swift
//  pennyflow
//
//  Created by Amine on 13/12/2024.
//

import SwiftUI

// MARK: Calendar Header View

struct CalendarHeaderView: View {
    @ObservedObject var viewModel: CalendarViewModel // Pass the ViewModel to manage state

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Main Title
            Text("Subs Schedule")
                .font(.largeTitle).bold()
                .foregroundColor(.white)

            // Subtitle
            Text("\(viewModel.subscriptions.count) subscriptions for today")
                .font(.subheadline)
                .foregroundColor(.gray)

            // Month Picker
            HStack {
                Spacer()
                Picker("Month", selection: $viewModel.selectedDate) {
                    ForEach(viewModel.availableMonths, id: \.self) { date in
                        Text(viewModel.monthName(for: date)) // Access the method directly
                            .tag(date) // Use the `Date` value as the tag
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .foregroundColor(.white)
            }
        }
        .padding(.horizontal)
    }
}
