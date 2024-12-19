//
//  SubscriptionsViewModel.swift
//  pennyflow
//
//  Created by Amine on 14/12/2024.
//


import Foundation
import CoreData

class SubscriptionsViewModel: ObservableObject {
    @Published var subscriptions: [Subscription] = [] // All Subscriptions array
    @Published var userSubscriptions: [Subscription] = [] // User current subscriptions array
    @Published var user: User?
    private let context: NSManagedObjectContext
    private var currentUser: User?                          // Current user reference

    // MARK: - Initializer

    // MARK: - Initialization
    init(context: NSManagedObjectContext, currentUser: User?) {
        self.context = context
        self.currentUser = currentUser
        fetchSubscriptions()
        fetchUserSubscriptions()
    }

    // MARK: - Fetch Subscriptions
    func fetchSubscriptions() {
        subscriptions = SubscriptionService.shared.fetchSubscriptions(context: context)
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
        userSubscriptions = SubscriptionService.shared.fetchUserSubscriptions(for: user, context: context)
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
        let newSubscription = SubscriptionService.shared.mapDTOToSubscription(dto: dto, context: context)
        newSubscription.user = user // Associate the subscription with the current user
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
            try SubscriptionService.shared.deleteSubscription(subscription, context: context)
            userSubscriptions.removeAll { $0.id == subscription.id }
        } catch {
            print("Failed to delete subscription: \(error.localizedDescription)")
            throw error
            
            
        }
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
