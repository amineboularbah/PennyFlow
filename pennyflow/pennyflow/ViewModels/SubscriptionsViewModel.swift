//
//  SubscriptionsViewModel.swift
//  pennyflow
//
//  Created by Amine on 14/12/2024.
//


import Foundation
import CoreData

class SubscriptionsViewModel: ObservableObject {
    @Published var subscriptions: [Subscription] = [] // Subscriptions array
    private let context: NSManagedObjectContext

    // MARK: - Initializer
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchSubscriptions()
    }

    // MARK: - Fetch Subscriptions
    func fetchSubscriptions() {
        subscriptions = SubscriptionService.shared.fetchSubscriptions(context: context)
    }

    // MARK: - Add a Subscription
    func addSubscription(from dto: SubscriptionDTO) {
        let _ = SubscriptionService.shared.mapDTOToSubscription(dto: dto, context: context)
        saveChanges()
        fetchSubscriptions()
    }

    // MARK: - Delete a Subscription
    func deleteSubscription(_ subscription: Subscription) {
        SubscriptionService.shared.deleteSubscription(subscription, context: context)
        fetchSubscriptions()
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
