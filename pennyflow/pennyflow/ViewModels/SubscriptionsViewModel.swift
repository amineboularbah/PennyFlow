//
//  SubscriptionsViewModel.swift
//  pennyflow
//
//  Created by Amine on 14/12/2024.
//

import CoreData
import Foundation

class SubscriptionsViewModel: ObservableObject {
    @Published var userSubscriptions: [Subscription] = []  // User current subscriptions array
    @Published var user: User?
    @Published var monthlyBills: (total: Double, spent: Double) = (
        total: 0, spent: 0
    )
    @Published var selectedFilter: BillFilter = .month // Default filter
    @Published var upcomingBills: [Bill] = []

    private let context: NSManagedObjectContext
    private var currentUser: User?
    
    // Current user reference

    // MARK: - Initialization
    init(context: NSManagedObjectContext, currentUser: User?) {
        self.context = context
        self.currentUser = currentUser
        fetchUserSubscriptions()

    }

    /// Calculate progress for circular visualization
    func calculateCircleProgress() -> Double {
        guard monthlyBills.total > 0 else { return 0.0 }  // Avoid division by zero
        let normalizedProgress = monthlyBills.spent / monthlyBills.total
        return normalizedProgress * 0.78  // Scale to 75% max fill
    }

    // MARK: - Get Highest Subscription
    func getHighestSubscription() -> String {

        if let highestSub = userSubscriptions.max(by: {
            ($0.price) < ($1.price)
        }) {
            return "$\(highestSub.price.formatted())"

        }
        return "$0"
    }

    // MARK: - Get Lowest Subscription
    func getLowestSubscription() -> String {
        if let minSub = userSubscriptions.min(by: { ($0.price) < ($1.price) }) {
            return "$\(minSub.price.formatted())"

        }
        return "$0"

    }

    // MARK: - Fetch User Subscriptions
    /**
     Fetch subscriptions linked to the current user and update `userSubscriptions`.
     */
    func fetchUserSubscriptions() {
        guard let user = currentUser else {
            print("No user is set in ProfileViewModel.")
            return
        }
        userSubscriptions = SubscriptionService.shared.fetchUserSubscriptions(
            for: user, context: context)
        
        //calculateMonthlyBills()
    }
    // MARK: - Add Subscription
    /**
     Adds a new subscription to Core Data and links it to the current user.

     - Parameter dto: The `SubscriptionDTO` object to map and save.
     */
    func addSubscription(from dto: SubscriptionDTO) {
        guard let user = currentUser else {
            print("Error: No user to associate with the subscription.")
            return
        }
        let newSubscription = SubscriptionService.shared.mapDTOToSubscription(
            dto: dto, context: context)
        newSubscription.user = user  // Associate the subscription with the current user
        saveChanges()
        userSubscriptions.append(newSubscription)
    }

    // MARK: - Delete Subscription
    /**
     Deletes a subscription from Core Data.

     - Parameter subscription: The `Subscription` entity to delete.
     */
    func deleteSubscription(_ subscription: Subscription) throws {
        do {
            try SubscriptionService.shared.deleteSubscription(
                subscription, context: context)
            userSubscriptions.removeAll { $0.id == subscription.id }
        } catch {
            print(
                "Failed to delete subscription: \(error.localizedDescription)")
            throw error

        }
    }
    
    // MARK: Filter subscriptions based on the selected filter
    func filterSubscriptions() {
        // Get the current date and calendar
        let calendar = Calendar.current
        let currentDate = Date()

        // Calculate the start of the current month
        guard let startOfCurrentMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate)),
              let endDate = calendar.date(byAdding: .month, value: selectedFilter.monthsInterval, to: startOfCurrentMonth) else {
            return
        }        // Create an empty list for the filtered results
        var results: [Bill] = []

        // Loop through all subscriptions and calculate due dates
        for subscription in userSubscriptions {
            var nextDueDate = subscription.startDate ?? Date()

            while nextDueDate <= endDate {
                if nextDueDate >= currentDate {
                    results.append(Bill(subscription: subscription, dueDate: nextDueDate)) // Add subscription with the calculated due date
                }

                // Increment the due date based on the subscription frequency
                nextDueDate = calculateNextDueDate(from: nextDueDate, frequency: subscription.reminder ?? "monthly")
            }
        }

        // Sort results by due date
        upcomingBills = results.sorted { $0.dueDate < $1.dueDate }
    }
    
    private func calculateNextDueDate(from date: Date, frequency: String) -> Date {
        let calendar = Calendar.current
        guard let frequencyEnum = Frequency(rawValue: frequency.lowercased()) else {
            return date
        }

        switch frequencyEnum {
        case .daily:
            return calendar.date(byAdding: .day, value: 1, to: date) ?? date
        case .weekly:
            return calendar.date(byAdding: .weekOfYear, value: 1, to: date) ?? date
        case .monthly:
            return calendar.date(byAdding: .month, value: 1, to: date) ?? date
        case .yearly:
            return calendar.date(byAdding: .year, value: 1, to: date) ?? date
        }
    }
    
    
    // MARK: - Calculate Monthly Bills and Spent Amount
    func calculateMonthlyBills() {
        print("Starting to calculate monthly bills...")
        let calendar = Calendar.current
        let now = Date()
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: now))!
        let endOfMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth)!
        
        var total: Double = 0.0
        var spent: Double = 0.0
        
        for subscription in userSubscriptions {
            if subscription.startDate == nil {
                print("Missing start date for subscription: \(subscription.name ?? "Unknown")")
            }
            
            if Frequency(rawValue: subscription.reminder?.lowercased() ?? "") == nil {
                print("Invalid reminder value for subscription: \(subscription.name ?? "Unknown")")
            }
            
            guard let startDate = subscription.startDate,
                  let frequency = Frequency(rawValue: subscription.reminder?.lowercased() ?? "Monthly") else {
                continue
            }

            // Calculate all due dates within this month
            let dueDates = calculateDueDates(
                startDate: startDate,
                frequency: frequency,
                startOfMonth: startOfMonth,
                endOfMonth: endOfMonth
            )
            
            // Add subscription price for each due date within this month
            for dueDate in dueDates {
                total += subscription.price
                if dueDate <= now {
                    spent += subscription.price
                }
            }
        }
        
        // update monthlyBills Tuple
        monthlyBills = (total, spent)
        print("Monthly Bills Calculated Successfully! Total: \(total), Spent: \(spent)")
    }
    
    // MARK: - Helper Function to Calculate Due Dates
    private func calculateDueDates(
        startDate: Date,
        frequency: Frequency,
        startOfMonth: Date,
        endOfMonth: Date
    ) -> [Date] {
        var dueDates: [Date] = []
        var currentDueDate = startDate
        let calendar = Calendar.current
        
        // Loop to find all due dates within the month
        while currentDueDate < endOfMonth {
            if currentDueDate >= startOfMonth {
                dueDates.append(currentDueDate)
            }
            
            // Advance the due date based on the subscription frequency
            switch frequency {
            case .daily:
                currentDueDate = calendar.date(byAdding: .day, value: 1, to: currentDueDate) ?? endOfMonth
            case .weekly:
                currentDueDate = calendar.date(byAdding: .weekOfYear, value: 1, to: currentDueDate) ?? endOfMonth
            case .monthly:
                currentDueDate = calendar.date(byAdding: .month, value: 1, to: currentDueDate) ?? endOfMonth
            case .yearly:
                currentDueDate = calendar.date(byAdding: .year, value: 1, to: currentDueDate) ?? endOfMonth
            }
        }
        
        return dueDates
    }

    // MARK: - Save Changes
    private func saveChanges() {
        do {
            try context.save()
            print("Changes saved successfully.")
        } catch {
            print("Failed to save changes: \(error)")
        }
    }
}
