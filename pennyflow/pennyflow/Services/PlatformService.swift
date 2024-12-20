//
//  PlatformService.swift
//  pennyflow
//
//  Created by Amine on 20/12/2024.
//

import CoreData
import Foundation

class PlatformService {
    // MARK: - Singleton Instance
    static let shared = PlatformService()
    
    // MARK: - Initialization
    private init() {}
    
    // MARK: - Load Platforms from JSON
    /**
     Loads platforms from a JSON file and saves them into Core Data if the Platform entity is empty.
     
     - Parameter context: The Core Data `NSManagedObjectContext` used to save the platforms.
     */
    func initializePlatformsIfNeeded(context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<Platform> = Platform.fetchRequest()
        do {
            let platformCount = try context.count(for: fetchRequest)
            if platformCount == 0 {
                print("Initializing platforms from JSON...")
                loadPlatformsFromJSON(context: context)
            }
        } catch {
            print("Error checking Platform entity: \(error.localizedDescription)")
        }
    }
    
    private func loadPlatformsFromJSON(context: NSManagedObjectContext) {
        guard let url = Bundle.main.url(forResource: "platforms", withExtension: "json") else {
            print("Platforms JSON file not found.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let platformDTOs = try decoder.decode([PlatformDTO].self, from: data)
            
            for dto in platformDTOs {
                if !isPlatformExists(id: dto.id, context: context) {
                    _ = mapDTOToPlatform(dto: dto, context: context)
                }
            }
            
            try context.save()
            print("Platforms successfully loaded from JSON and saved to Core Data.")
        } catch {
            print("Error loading or decoding JSON: \(error.localizedDescription)")
        }
    }
    
    // MARK: - CRUD Operations
    /**
     Adds or updates a platform in Core Data.
     
     - Parameters:
       - platformDTO: The data transfer object containing the platform details.
       - context: The Core Data `NSManagedObjectContext` used to save the platform.
     */
    func savePlatform(platformDTO: PlatformDTO, category: Category?, context: NSManagedObjectContext) throws {
        let platform = isPlatformExists(id: platformDTO.id, context: context)
            ? fetchPlatform(id: platformDTO.id, context: context)
            : Platform(context: context)
        
        platform?.id = platformDTO.id
        platform?.name = platformDTO.name
        platform?.image = platformDTO.image
        platform?.desc = platformDTO.desc
        platform?.category = category
        
        try context.save()
    }
    
    /**
     Fetches all platforms from Core Data.
     
     - Parameter context: The Core Data `NSManagedObjectContext`.
     - Returns: An array of `Platform` entities.
     */
    func fetchPlatforms(context: NSManagedObjectContext) -> [Platform] {
        let fetchRequest: NSFetchRequest<Platform> = Platform.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching platforms: \(error.localizedDescription)")
            return []
        }
    }
    
    /**
     Deletes a platform from Core Data.
     
     - Parameters:
       - platform: The platform entity to delete.
       - context: The Core Data `NSManagedObjectContext`.
     */
    func deletePlatform(_ platform: Platform, context: NSManagedObjectContext) throws {
        context.delete(platform)
        try context.save()
    }
    
    // MARK: - Helper Methods
    private func isPlatformExists(id: UUID, context: NSManagedObjectContext) -> Bool {
        let fetchRequest: NSFetchRequest<Platform> = Platform.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        do {
            return try context.count(for: fetchRequest) > 0
        } catch {
            print("Error checking if platform exists: \(error.localizedDescription)")
            return false
        }
    }
    
    private func fetchPlatform(id: UUID, context: NSManagedObjectContext) -> Platform? {
        let fetchRequest: NSFetchRequest<Platform> = Platform.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        do {
            return try context.fetch(fetchRequest).first
        } catch {
            print("Error fetching platform: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func mapDTOToPlatform(dto: PlatformDTO, context: NSManagedObjectContext) -> Platform {
        let platform = Platform(context: context)
        platform.id = dto.id
        platform.name = dto.name
        platform.image = dto.image
        
        
        return platform
    }
}
