//
//  UserService.swift
//  pennyflow
//
//  Created by Amine on 14/12/2024.
//

import CoreData

class UserService {
    private let context = PersistenceController.shared.context

    // MARK: - Fetch User
    func fetchUser() -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.fetchLimit = 1 // Fetch only one user

        do {
            return try context.fetch(request).first
        } catch {
            print("Error fetching user: \(error.localizedDescription)")
            return nil
        }
    }
    // MARK: - Save User
    func saveUser(
        name: String, email: String, icloudSyncEnabled: Bool,
        securityMethod: String, defaultCurrency: String, appIcon: String,
        theme: String, font: String
    ) throws -> User {
        let user = User(context: context)
        user.id = UUID()
        user.name = name
        user.email = email
        user.icloudSyncEnabled = icloudSyncEnabled
        user.securityMethod = securityMethod
        user.defaultCurrency = defaultCurrency
        user.appIcon = appIcon
        user.theme = theme
        user.font = font

        do {
            try context.save()
            print("User saved successfully")
            return user
        } catch {
            print("Failed to save user: \(error)")
            throw error
        }
    }

    // MARK: - Update User
    func updateUser(
        user: User,
        name: String? = nil,
        email: String? = nil,
        icloudSyncEnabled: Bool? = nil,
        securityMethod: String? = nil,
        defaultCurrency: String? = nil,
        appIcon: String? = nil,
        theme: String? = nil,
        font: String? = nil
    ) throws {
        // Update properties if provided
        if let name = name { user.name = name }
        if let email = email { user.email = email }
        if let icloudSyncEnabled = icloudSyncEnabled {
            user.icloudSyncEnabled = icloudSyncEnabled
        }
        if let securityMethod = securityMethod {
            user.securityMethod = securityMethod
        }
        if let defaultCurrency = defaultCurrency {
            user.defaultCurrency = defaultCurrency
        }
        if let appIcon = appIcon { user.appIcon = appIcon }
        if let theme = theme { user.theme = theme }
        if let font = font { user.font = font }

        // Save changes and handle errors
        do {
            try context.save()
            print("User updated successfully")
        } catch {
            print("Failed to update user: \(error)")
            throw error  // Re-throw the error so it can be caught by the caller
        }
    }
}
