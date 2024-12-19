//
//  CategoryViewModel.swift
//  pennyflow
//
//  Created by Amine on 19/12/2024.
//

import SwiftUI
import CoreData

class CategoryViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var userCategories: [Category] = []
    @Published var errorMessage: String?

    private let context: NSManagedObjectContext
    private let currentUser: User?

    init(context: NSManagedObjectContext, currentUser: User?) {
        self.context = context
        self.currentUser = currentUser
        fetchCategories()
    }

    // MARK: - Fetch Categories
    func fetchCategories() {
        categories = CategoryService.shared.fetchCategories(context: context)
    }
    
    // MARK: - Fetch User Categories
    /**
     Fetch categories linked to the current user and update `userCategories`.
     */
    func fetchUserCategories() {
        guard let user = currentUser else {
            print("No user is set in ProfileViewModel.")
            return
        }
        userCategories = CategoryService.shared.fetchUserCategories(for: user, context: context)
    }

    // MARK: - Add New Category
    func addCategory(name: String, color: String, budget: Double, image: String) {
        guard let user = currentUser else {
            print("Error: No user to associate with the Category.")
            return
        }
        do {
            let newCategory = try CategoryService.shared.createCategory(
                name: name,
                color: color,
                budget: budget,
                image: image,
                user: user,
                context: context
            )
            categories.append(newCategory)
        } catch {
            errorMessage = "Failed to add category: \(error.localizedDescription)"
        }
    }

    // MARK: - Update Existing Category
    func updateCategory(
        category: Category,
        name: String? = nil,
        color: String? = nil,
        budget: Double? = nil,
        image: String? = nil
    ) {
        do {
            try CategoryService.shared.updateCategory(
                category: category,
                name: name,
                color: color,
                budget: budget,
                image: image,
                context: context
            )
            fetchCategories()
        } catch {
            errorMessage = "Failed to update category: \(error.localizedDescription)"
        }
    }

    // MARK: - Add Subscription to a Category
    func addSubscription(to category: Category, subscription: Subscription) {
        do {
            try CategoryService.shared.addSubscription(
                to: category,
                subscription: subscription,
                context: context
            )
            fetchCategories() // Update the UI to reflect changes
        } catch {
            errorMessage = "Failed to add subscription to category: \(error.localizedDescription)"
        }
    }

    // MARK: - Delete Category
    func deleteCategory(category: Category) {
        do {
            try CategoryService.shared.deleteCategory(category: category, context: context)
            categories.removeAll { $0.id == category.id }
        } catch {
            errorMessage = "Failed to delete category: \(error.localizedDescription)"
        }
    }
}
