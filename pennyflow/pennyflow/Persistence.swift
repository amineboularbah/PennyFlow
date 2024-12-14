//
//  Persistence.swift
//  pennyflow
//
//  Created by Amine on 29/11/2024.
//

import CoreData

class PersistenceController {
    static let shared = PersistenceController() // Singleton instance

    let container: NSPersistentContainer

    // MARK: - Initializer
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "pennyflow") // Replace with your Core Data model name

        if inMemory {
            // In-memory store for testing and previews
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        // Enable lightweight migrations
        let description = container.persistentStoreDescriptions.first
        description?.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        description?.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)

        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }

        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    // MARK: - Core Data Context
    var context: NSManagedObjectContext {
        container.viewContext
    }

    // MARK: - Save Context
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                print("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    // MARK: - Preview Instance
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let viewContext = controller.container.viewContext

        // Add mock data
        for index in 0..<5 {
            let newSubscription = Subscription(context: viewContext)
            newSubscription.id = UUID()
            newSubscription.name = "Mock Subscription \(index + 1)"
            newSubscription.price = Double(index + 1) * 10.0
            newSubscription.icon = "icon\(index + 1)"
            newSubscription.startDate = Date()
        }

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            print("Unresolved error in preview context \(nsError), \(nsError.userInfo)")
        }

        return controller
    }()
}
