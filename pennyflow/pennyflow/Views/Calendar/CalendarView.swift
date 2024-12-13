//
//  CalendarView.swift
//  pennyflow
//
//  Created by Amine on 7/12/2024.
//
import SwiftUI

struct CalendarView: View {
    @StateObject private var viewModel = CalendarViewModel()

    var body: some View {
        VStack(spacing: 20) {
            CalendarHeaderView(viewModel: viewModel)
            WeekView(viewModel: viewModel)
            CalendarMonthlyBillsView(viewModel: viewModel)
            CalendarSubscriptionsGridView(viewModel: viewModel)
            Spacer()
        }
        .padding(.horizontal)
        .applyDefaultBackground()
        .navigationTitle("Calendar")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: Preview
struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .applyDefaultBackground()
    }
}

