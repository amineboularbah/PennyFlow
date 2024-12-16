import CoreData

class SubscriptionService {
    // MARK: - Singleton Instance
    static let shared = SubscriptionService()  // Shared instance for centralized access.

    // MARK: - Private Constructor
    private init() {}  // Prevent external instantiation to enforce singleton pattern.

    // MARK: - Initialize Subscriptions If Needed
    /**
    Checks if the subscriptions table is empty and initializes it from JSON if necessary.

    - Parameter context: The Core Data managed object context.
    */
    func initializeSubscriptionsIfNeeded(context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<Subscription> =
            Subscription.fetchRequest()
        fetchRequest.fetchLimit = 1

        do {
            let count = try context.count(for: fetchRequest)
            if count == 0 {
                print("No subscriptions found. Initializing from JSON...")
                loadSubscriptionsFromJSON(context: context)
            } else {
                print("Subscriptions already initialized.")
            }
        } catch {
            print(
                "Failed to check subscriptions count: \(error.localizedDescription)"
            )
        }
    }

    // MARK: - Load Subscriptions from JSON
    /**
     Loads subscriptions from a local JSON file and saves them into Core Data if not already present.

     - Parameter context: The Core Data managed object context used for saving subscriptions.
     */
    func loadSubscriptionsFromJSON(context: NSManagedObjectContext) {
        guard
            let url = Bundle.main.url(
                forResource: "subscriptions", withExtension: "json")
        else {
            print("JSON file not found.")
            return
        }

        do {
            // Decode JSON data into SubscriptionDTO objects.
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601  // Decode ISO8601 date format.
            let subscriptionDTOs = try decoder.decode(
                [SubscriptionDTO].self, from: data)

            for dto in subscriptionDTOs {
                // Avoid duplicate entries by checking if the subscription already exists by id or name.
                if !isSubscriptionExists(
                    id: dto.id, name: dto.name, context: context)
                {
                    let subscription = mapDTOToSubscription(
                        dto: dto, context: context)
                    print(
                        "Added new subscription: \(subscription.name ?? "Unknown")"
                    )
                } else {
                    print("Subscription already exists: \(dto.name)")
                }
            }

            try context.save()
            print(
                "Subscriptions successfully loaded from JSON and saved to Core Data."
            )
        } catch {
            print(
                "Error loading or decoding JSON: \(error.localizedDescription)")
        }
    }

    // MARK: - Check Subscription Existence
    /**
     Checks if a subscription with a specific ID exists in Core Data.

     - Parameters:
       - id: The UUID of the subscription to check.
       - context: The Core Data managed object context.
     - Returns: `true` if the subscription exists, `false` otherwise.
     */
    func isSubscriptionExists(
        id: UUID, name: String, context: NSManagedObjectContext
    ) -> Bool {
        let fetchRequest: NSFetchRequest<Subscription> =
            Subscription.fetchRequest()
        fetchRequest.predicate = NSCompoundPredicate(
            orPredicateWithSubpredicates: [
                NSPredicate(format: "id == %@", id as CVarArg),
                NSPredicate(format: "name == %@", name),
            ])

        do {
            let count = try context.count(for: fetchRequest)
            return count > 0  // Return true if any subscription matches either id or name
        } catch {
            print(
                "Error checking subscription existence: \(error.localizedDescription)"
            )
            return false  // Assume the subscription does not exist on error
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
    func mapDTOToSubscription(
        dto: SubscriptionDTO, context: NSManagedObjectContext
    ) -> Subscription {
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
            subscription.category = fetchOrCreateCategory(
                named: categoryName, context: context)
        }

        return subscription
    }

    // MARK: - Fetch or Create Category
    /**
     Fetches or creates a category in Core Data.

     - Parameters:
       - name: The name of the category.
       - context: The Core Data managed object context.
     - Returns: A `Category` entity.
     */
    private func fetchOrCreateCategory(
        named name: String, context: NSManagedObjectContext
    ) -> Category {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)

        if let category = try? context.fetch(fetchRequest).first {
            return category
        } else {
            let newCategory = Category(context: context)
            newCategory.name = name
            return newCategory
        }
    }

    // MARK: - Fetch All Subscriptions
    /**
     Fetches all subscriptions from Core Data.

     - Parameter context: The Core Data managed object context.
     - Returns: An array of `Subscription` objects.
     */
    func fetchSubscriptions(context: NSManagedObjectContext) -> [Subscription] {
        let fetchRequest: NSFetchRequest<Subscription> =
            Subscription.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print(
                "Failed to fetch subscriptions: \(error.localizedDescription)")
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
    func deleteSubscription(
        _ subscription: Subscription, context: NSManagedObjectContext
    ) {
        context.delete(subscription)
        do {
            try context.save()
            print("Subscription deleted successfully.")
        } catch {
            print(
                "Failed to delete subscription: \(error.localizedDescription)")
        }
    }
}
