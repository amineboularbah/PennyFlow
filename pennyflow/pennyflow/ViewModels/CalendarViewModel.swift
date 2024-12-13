//
//  CalendarViewModel.swift
//  pennyflow
//
//  Created by Amine on 13/12/2024.
//
import SwiftUI

// MARK: - ViewModel
class CalendarViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var selectedDate: Date // Tracks the currently selected date
    @Published var subscriptions: [Subscription] = SubscriptionService.fetchSubscriptions()
    
    // MARK: - Computed Properties
    /// Generates all the dates for the current month.
    var currentMonthDays: [Date] {
        let calendar = Calendar.current
        guard let range = calendar.range(of: .day, in: .month, for: selectedDate) else { return [] }
        
        let firstOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: selectedDate))!
        return range.map { day -> Date in
            calendar.date(byAdding: .day, value: day - 1, to: firstOfMonth)!
        }
    }
    
    /// Provides the full name of the selected month (e.g., "January").
    var selectedMonth: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM" // Full month name
        return dateFormatter.string(from: selectedDate)
    }
    
    /// Provides an array of `Date` values for available months.
    var availableMonths: [Date] {
        let calendar = Calendar.current
        let startOfYear = calendar.date(from: calendar.dateComponents([.year], from: Date()))!
        return (0..<12).compactMap { monthOffset in
            calendar.date(byAdding: .month, value: monthOffset, to: startOfYear)
        }
    }

    // MARK: - Initializer
    init() {
        selectedDate = Date() // Default to today's date
    }
    
    // MARK: - Helper Methods
    /// Formats a given date to display the month name (e.g., "January").
    func monthName(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: date)
    }
    
    /// Formats a given date to display the day (e.g., "13").
    func day(for date: Date) -> String {
        let calendar = Calendar.current
        return String(calendar.component(.day, from: date))
    }

    /// Formats a given date to display the weekday abbreviation (e.g., "Fr").
    func weekday(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E" // Weekday abbreviation
        return dateFormatter.string(from: date)
    }
    
    /// Checks if a given date is the selected date.
    func isSelectedDate(_ date: Date) -> Bool {
        Calendar.current.isDate(date, inSameDayAs: selectedDate)
    }

    /// Updates the selected date.
    func selectDate(_ date: Date) {
        selectedDate = date
    }
}
