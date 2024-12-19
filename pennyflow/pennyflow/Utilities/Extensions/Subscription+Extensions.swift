//
//  Subscription+Extensions.swift
//  pennyflow
//
//  Created by Amine on 18/12/2024.
//

import Foundation


extension Subscription {
    // Computed property for due date
    func calculateDueDate() -> Date? {
        // Ensure `startDate` and `reminder` are non-nil
        guard let startDate = self.startDate,
              let reminder = self.reminder,
              let frequency = Frequency(rawValue: reminder) else {
            return nil
        }

        let calendar = Calendar.current

        // Calculate due date based on frequency
        switch frequency {
        case .daily:
            return calendar.date(byAdding: .day, value: 1, to: startDate)
        case .weekly:
            return calendar.date(byAdding: .weekOfYear, value: 1, to: startDate)
        case .monthly:
            return calendar.date(byAdding: .month, value: 1, to: startDate)
        case .yearly:
            return calendar.date(byAdding: .year, value: 1, to: startDate)
        }
    }
}
