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
    @Published var balance: String = ""
    @Published var selectedCurrency: Currency = .usd
    @Published var isFormValid = false
    @Published var errorMessage: String? = nil // Holds the error message for the View
    @Published var navigateToMainScreen: Bool = false // Tracks navigation state
    
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
        if let currencyString = fetchedUser.defaultCurrency,
           let currency = Currency(rawValue: currencyString) {
            self.selectedCurrency = currency
        } else {
            // Fallback to a default currency if the mapping fails
            self.selectedCurrency = .usd
        }
        //self.balance = fetchedUser.balance ?? ""
        self.profileImageData = fetchedUser.profilePicture ?? nil
        self.isICloudSyncEnabled = fetchedUser.icloudSyncEnabled
    }

    // Save or Update the user data in Core Data

    func saveUserData() {
        if let existingUser = user {
            do {
                try userService.updateUser(
                    user: existingUser,
                    name: name,
                    email: email,
                    icloudSyncEnabled: isICloudSyncEnabled,
                    appIcon: nil,
                    theme: nil,
                    font: nil
                )
                navigateToMainScreen = true // Navigate on success
            } catch {
                errorMessage = error.localizedDescription // Set error message
            }
        } else {
            do {
                user = try userService.saveUser(
                    name: name,
                    email: email,
                    icloudSyncEnabled: false, // Default
                    securityMethod: "face_id", // Default
                    defaultCurrency: "USD ($)", // Default
                    appIcon: "default", // Default
                    theme: "dark", // Default
                    font: "Inter" // Default
                )
                navigateToMainScreen = true // Navigate on success
            } catch {
                errorMessage = error.localizedDescription // Set error message
            }
        }
    }
    
    
    func editProfile() {
        // Placeholder for now; can add edit-specific logic later
        print("Edit Profile tapped")
    }
}
