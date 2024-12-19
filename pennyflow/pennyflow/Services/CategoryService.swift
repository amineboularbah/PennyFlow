//
//  CategoryService.swift
//  pennyflow
//
//  Created by Amine on 19/12/2024.
//

import CoreData

class CategoryService {
    static let shared = CategoryService()

    private init() {}

    // MARK: - Create a New Category
    func createCategory(
        name: String,
        color: String,
        budget: Double,
        image: String,
        user: User,
        context: NSManagedObjectContext
    ) throws -> Category {
        let category = Category(context: context)
        category.id = UUID()
        category.name = name
        category.color = color
        category.budget = budget
        category.image = image
        category.user = user

        try saveContext(context: context)
        return category
    }

    // MARK: - Fetch All Categories
    func fetchCategories(context: NSManagedObjectContext) -> [Category] {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch categories: \(error.localizedDescription)")
            return []
        }
    }
    
    
    // MARK: - Fetch User Categories for a User
    func fetchUserCategories(for user: User, context: NSManagedObjectContext) -> [Category] {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "user == %@", user)
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch user categories: \(error.localizedDescription)")
            return []
        }
    }

    // MARK: - Add Subscription to a Category
    func addSubscription(
        to category: Category,
        subscription: Subscription,
        context: NSManagedObjectContext
    ) throws {
        if ((category.subscriptions?.contains(subscription)) == nil) ?? false {
            category.addToSubscriptions(subscription)
        }
        try saveContext(context: context)
    }

    // MARK: - Update a Category
    func updateCategory(
        category: Category,
        name: String? = nil,
        color: String? = nil,
        budget: Double? = nil,
        image: String? = nil,
        context: NSManagedObjectContext
    ) throws {
        if let name = name { category.name = name }
        if let color = color { category.color = color }
        if let budget = budget { category.budget = budget }
        if let image = image { category.image = image }

        try saveContext(context: context)
    }

    // MARK: - Delete a Category
    func deleteCategory(category: Category, context: NSManagedObjectContext) throws {
        context.delete(category)
        try saveContext(context: context)
    }

    // MARK: - Save Context
    private func saveContext(context: NSManagedObjectContext) throws {
        if context.hasChanges {
            try context.save()
        }
    }
    
    
    
    // MARK: - Initialize Categories If Needed
    /**
     Loads categories from a local JSON file and saves them into Core Data
     if the `Category` entity is empty.
     
     - Parameter context: The Core Data managed object context.
     */
    func initializeCategoriesIfNeeded(context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            let count = try context.count(for: fetchRequest)
            if count == 0 {
                print("Category entity is empty. Loading data from JSON...")
                loadCategoriesFromJSON(context: context)
            } else {
                print("Categories already exist. Skipping initialization.")
            }
        } catch {
            print("Failed to fetch categories: \(error.localizedDescription)")
        }
    }

    // MARK: - Load Categories from JSON
    /**
     Loads categories from a local JSON file and saves them to Core Data.
     
     - Parameter context: The Core Data managed object context.
     */
    func loadCategoriesFromJSON(context: NSManagedObjectContext) {
        guard let url = Bundle.main.url(forResource: "categories", withExtension: "json") else {
            print("Categories JSON file not found.")
            return
        }

        do {
            // Decode JSON data into CategoryDTO objects.
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let categoryDTOs = try decoder.decode([CategoryDTO].self, from: data)

            // Map DTOs to Core Data entities and save them.
            for dto in categoryDTOs {
                _ = mapDTOToCategory(dto: dto, context: context)
            }

            try context.save()
            print("Categories successfully loaded from JSON and saved to Core Data.")
        } catch {
            print("Error loading or decoding categories JSON: \(error.localizedDescription)")
        }
    }

    // MARK: - Map DTO to Core Data Entity
    /**
     Maps a `CategoryDTO` object to a Core Data `Category` entity.
     
     - Parameters:
       - dto: The DTO object containing category data.
       - context: The Core Data managed object context.
     - Returns: A `Category` entity.
     */
    func mapDTOToCategory(dto: CategoryDTO, context: NSManagedObjectContext) -> Category {
        let category = Category(context: context)
        category.id = UUID()
        category.name = dto.name
        category.color = dto.color
        category.budget = dto.budget
        category.image = dto.image
        return category
    }
}
