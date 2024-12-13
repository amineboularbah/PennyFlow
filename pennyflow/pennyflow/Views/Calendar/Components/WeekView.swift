//
//  WeekView.swift
//  pennyflow
//
//  Created by Amine on 13/12/2024.
//

import SwiftUI

// MARK: - Scrollable Week View
struct WeekView: View {
    @ObservedObject var viewModel: CalendarViewModel

     var body: some View {
         ScrollViewReader { proxy in
             ScrollView(.horizontal, showsIndicators: false) {
                 HStack(spacing: 12) {
                     ForEach(viewModel.currentMonthDays, id: \.self) { date in
                         VStack {
                             Text(viewModel.day(for: date)) // Day (e.g., "13")
                                 .font(.headline)
                                 .foregroundColor(viewModel.isSelectedDate(date) ? .white : .gray)
                             Text(viewModel.weekday(for: date)) // Weekday (e.g., "Fr")
                                 .font(.subheadline)
                                 .foregroundColor(viewModel.isSelectedDate(date) ? .white : .gray)
                         }
                         .padding()
                         .background(viewModel.isSelectedDate(date) ? Color.accentColor : Color.gray.opacity(0.2))
                         .clipShape(RoundedRectangle(cornerRadius: 10))
                         .id(date) // Assign a unique ID to each date
                         .onTapGesture {
                             viewModel.selectDate(date)
                         }
                     }
                 }
                 .onAppear {
                     // Scroll to the current date on appear
                     if let today = viewModel.currentMonthDays.first(where: { viewModel.isSelectedDate($0) }) {
                         proxy.scrollTo(today, anchor: .leading)
                     }
                 }
             }
         }
     }
 }
