import CoreData

class SubscriptionService {
    // MARK: - Singleton Instance
    static let shared = SubscriptionService() // Shared instance for centralized access.

    // MARK: - Private Constructor
    private init() {} // Prevent external instantiation to enforce singleton pattern.

    // MARK: - Load Subscriptions from JSON
    /**
     Loads subscriptions from a local JSON file and saves them into Core Data.
     
     - Parameter context: The Core Data managed object context used for saving subscriptions.
     */
    func loadSubscriptionsFromJSON(context: NSManagedObjectContext) {
        guard let url = Bundle.main.url(forResource: "subscriptions", withExtension: "json") else {
            print("JSON file not found.")
            return
        }

        do {
            // Decode JSON data into SubscriptionDTO objects.
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601 // Decode ISO8601 date format.
            let subscriptionDTOs = try decoder.decode([SubscriptionDTO].self, from: data)

            // Map each DTO to a Subscription entity and save it to Core Data.
            for dto in subscriptionDTOs {
                // Avoid duplicate entries by checking if the subscription already exists.
                let fetchRequest: NSFetchRequest<Subscription> = Subscription.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id == %@", dto.id as CVarArg)

                if let existing = try? context.fetch(fetchRequest), existing.isEmpty {
                    _ = mapDTOToSubscription(dto: dto, context: context)
                }
            }

            try context.save()
            print("Subscriptions successfully loaded from JSON and saved to Core Data.")
        } catch {
            print("Error loading or decoding JSON: \(error)")
        }
    }

    // MARK: - Map DTO to Core Data Entity
    /**
     Maps a `SubscriptionDTO` object to a Core Data `Subscription` entity.
     
     - Parameters:
       - dto: The DTO object containing subscription data.
       - context: The Core Data managed object context.
     - Returns: A `Subscription` entity.
     */
    func mapDTOToSubscription(dto: SubscriptionDTO, context: NSManagedObjectContext) -> Subscription {
        let subscription = Subscription(context: context)
        subscription.id = dto.id
        subscription.name = dto.name
        subscription.price = dto.price
        subscription.icon = dto.icon
        subscription.desc = dto.desc
        subscription.startDate = dto.startDate
        subscription.reminder = dto.reminder

        // Handle the Category relationship
        if let categoryName = dto.categoryName {
            let categoryFetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
            categoryFetchRequest.predicate = NSPredicate(format: "name == %@", categoryName)
            if let category = try? context.fetch(categoryFetchRequest).first {
                subscription.category = category
            } else {
                let newCategory = Category(context: context)
                newCategory.name = categoryName
                subscription.category = newCategory
            }
        }

        return subscription
    }

    // MARK: - Fetch All Subscriptions
    /**
     Fetches all subscriptions from Core Data.
     
     - Parameter context: The Core Data managed object context.
     - Returns: An array of `Subscription` objects.
     */
    func fetchSubscriptions(context: NSManagedObjectContext) -> [Subscription] {
        let fetchRequest: NSFetchRequest<Subscription> = Subscription.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch subscriptions: \(error)")
            return []
        }
    }

    // MARK: - Delete a Subscription
    /**
     Deletes a specific subscription from Core Data.
     
     - Parameters:
       - subscription: The subscription entity to delete.
       - context: The Core Data managed object context.
     */
    func deleteSubscription(_ subscription: Subscription, context: NSManagedObjectContext) {
        context.delete(subscription)
        do {
            try context.save()
            print("Subscription deleted successfully.")
        } catch {
            print("Failed to delete subscription: \(error)")
        }
    }
}
