//
//  PlatformViewModel.swift
//  pennyflow
//
//  Created by Amine on 20/12/2024.
//


import SwiftUI
import CoreData

class PlatformViewModel: ObservableObject {
    // MARK: - Properties
    @Published var platforms: [Platform] = []  // Holds all platforms
    @Published var errorMessage: String?       // For error handling
    private let context: NSManagedObjectContext

    // MARK: - Initialization
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchPlatforms()
    }

    // MARK: - Fetch Platforms
    /**
     Fetches all platforms from Core Data and updates the `platforms` property.
     */
    func fetchPlatforms() {
        do {
            self.platforms = PlatformService.shared.fetchPlatforms(context: context)
        } catch {
            self.errorMessage = "Failed to fetch platforms: \(error.localizedDescription)"
        }
    }

    // MARK: - Add Platform
    /**
     Adds a new platform to Core Data.

     - Parameters:
       - id: The UUID of the platform.
       - name: The name of the platform.
       - image: The image name or URL for the platform.
       - category: The category to which the platform belongs.
     */
    func addPlatform(id: UUID, name: String, image: String, category: Category, description: String) {
        let dto = PlatformDTO(id: id, name: name, image: image, desc: description)
        do {
            try PlatformService.shared.savePlatform(platformDTO: dto, category: category, context: context)
            fetchPlatforms()  // Refresh platforms after adding
        } catch {
            self.errorMessage = "Failed to add platform: \(error.localizedDescription)"
        }
    }

    // MARK: - Delete Platform
    /**
     Deletes a platform from Core Data.

     - Parameter platform: The platform entity to delete.
     */
    func deletePlatform(_ platform: Platform) {
        do {
            try PlatformService.shared.deletePlatform(platform, context: context)
            fetchPlatforms()  // Refresh platforms after deletion
        } catch {
            self.errorMessage = "Failed to delete platform: \(error.localizedDescription)"
        }
    }

    // MARK: - Filter Platforms by Category
    /**
     Filters platforms by a specific category.

     - Parameter category: The category to filter by.
     - Returns: An array of platforms belonging to the given category.
     */
    func platformsForCategory(_ category: Category) -> [Platform] {
        return platforms.filter { $0.category == category }
    }

    // MARK: - Initialize Platforms if Needed
    /**
     Initializes platforms by loading them from JSON if the Platform entity is empty.
     */
    func initializePlatformsIfNeeded() {
        PlatformService.shared.initializePlatformsIfNeeded(context: context)
        fetchPlatforms()
    }
}
