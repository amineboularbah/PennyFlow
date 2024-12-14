//
//  UserViewModel.swift
//  pennyflow
//
//  Created by Amine on 14/12/2024.
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    // MARK: - Profile Information
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var profileImageData: Data? = nil // Store as Data? for images
    
    // MARK: - State for Switches
    @Published var isICloudSyncEnabled: Bool = false

    // MARK: - Private Properties
    private let userService = UserService()
    private var user: User? // Hold the Core Data User object
    
    // MARK: - Initialization
    init() {
        loadUserData() // Load data on initialization
    }

    // MARK: - Methods
    
    // Load the user data from Core Data
    func loadUserData() {
        guard let fetchedUser = userService.fetchUser() else {
            print("No user found")
            return
        }
        self.user = fetchedUser
        self.name = fetchedUser.name ?? ""
        self.email = fetchedUser.email ?? ""
        self.profileImageData = fetchedUser.profilePicture ?? nil
        self.isICloudSyncEnabled = fetchedUser.icloudSyncEnabled
    }

    // Save or Update the user data in Core Data
    func saveUserData() {
        if let existingUser = user {
            // Update the existing user
            userService.updateUser(
                user: existingUser,
                name: name,
                email: email,
                icloudSyncEnabled: isICloudSyncEnabled,
                appIcon: nil,
                theme: nil,
                font: nil
            )
        } else {
            // Create a new user
            user = userService.saveUser(
                name: name,
                email: email,
                icloudSyncEnabled: false, // For now this will always be disabled
                securityMethod: "face_id", // Default
                defaultCurrency: "USD ($)", // Default
                appIcon: "default", // Default
                theme: "dark", // Default
                font: "Inter" // Default
            )
        }
    }
    
    func editProfile() {
        // Placeholder for now; can add edit-specific logic later
        print("Edit Profile tapped")
    }
}
