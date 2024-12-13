//
//  CalendarViewModel.swift
//  pennyflow
//
//  Created by Amine on 13/12/2024.
//
import SwiftUI

class CalendarViewModel: ObservableObject {
    @Published var selectedDay: Int = 8
    @Published var selectedMonth: String = "January"
    @Published var subscriptions: [Subscription] =
        SubscriptionService.fetchSubscriptions()

    func weekday(for day: Int) -> String {
        let weekdays = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]
        return weekdays[(day - 8) % weekdays.count]
    }
}
