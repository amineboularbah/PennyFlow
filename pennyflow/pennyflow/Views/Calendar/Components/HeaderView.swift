//
//  HeaderView.swift
//  pennyflow
//
//  Created by Amine on 13/12/2024.
//

import SwiftUI

// MARK: - Calendar Header View
struct CalendarHeaderView: View {
    @ObservedObject var viewModel: CalendarViewModel  // Pass the ViewModel to manage state

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Main Title
            Text("Subs\nSchedule")
                .font(.largeTitle).bold()
                .foregroundColor(.white)

            // Subtitle
            HStack {
                Text("\(viewModel.subscriptions.count) subscriptions for today")
                    .font(.headline7)
                    .foregroundColor(.gray30)
                Spacer()
                // Month Picker Button
                SecondaryButton(title: viewModel.monthName(for: viewModel.selectedDate), action: {
                    viewModel.showDatePicker = true
                }, width: 100, isFilled: true, textColor: .white, suffixIcon: "dorp_down")
                .sheet(isPresented: $viewModel.showDatePicker) {
                    VStack {
                        // Graphical Date Picker
                        DatePicker(
                            "Select Date",
                            selection: $viewModel.selectedDate,
                            displayedComponents: [.date]
                        )
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .cornerRadius(15)
                        .padding()
                        .onChange(of: viewModel.selectedDate) { _ in
                            viewModel.showDatePicker = false  // Close the sheet after selection
                        }
                        .tint(.secondaryC)
                        .colorScheme(.dark)

                        Spacer()
                    }
                    .background(Color.gray80)
                    .presentationDetents([.height(400), .medium, .large])  // Fixed detents
                }
            }
        }
    }
}
