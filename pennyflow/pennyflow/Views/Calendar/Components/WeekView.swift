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
                        VStack(spacing: 4) {
                            Text(viewModel.day(for: date))  // Day (e.g., "13")
                                .appTextStyle(font: .headline5)
                            Text(viewModel.weekday(for: date))  // Weekday (e.g., "Fr")
                                .appTextStyle(font: .bodySmall, color: .gray30)
                            Spacer()
                            
                            
                            if viewModel.isSelectedDate(date) {
                                RoundedRectangle(cornerRadius: CalendarStyles.cornerRadius)
                                    .frame(width: 6, height: 6)
                                    .background(Color.secondaryC)
                                    .foregroundColor(Color.secondaryC)
                                    .clipShape(RoundedRectangle(cornerRadius: CalendarStyles.cornerRadius))
                                    .padding(.bottom, 8)
                            }
                        
                        }
                        .padding(8)
                        .frame(width: 50, height: 100)
                        .background(
                            Color.gray60.opacity(viewModel.isSelectedDate(date) ? 1 : 0.2)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: CalendarStyles.cornerRadius))
                        .id(date)  // Assign a unique ID to each date
                        .onTapGesture {
                            viewModel.selectDate(date)
                        }
                        
                    }
                }
                .onAppear {
                    // Scroll to the current date on appear
                    scrollToSelectedDate(proxy)
                }
                .onChange(of: viewModel.selectedDate) { _ in
                    // Scroll to the selected date when it changes
                    scrollToSelectedDate( proxy)
                }
            }
        }
    }
    
    private func scrollToSelectedDate(_ proxy: ScrollViewProxy) {
        if let today = viewModel.currentMonthDays.first(where: { viewModel.isSelectedDate($0) }) {
            withAnimation {
                proxy.scrollTo(today, anchor: .leading)
            }
        }
    }
}
