//
//  ProfileViewModel.swift
//  pennyflow
//
//  Created by Amine on 14/12/2024.
//


import SwiftUI

class SettingsViewModel: ObservableObject {
    // MARK: - Profile Information
    @Published var name: String = "Amine Boularbah"
    @Published var email: String = "hello@amineboularbah.com"
    @Published var profileImage: String = "u1"

    // MARK: - State for Switches
    @Published var isICloudSyncEnabled: Bool = false

    // MARK: - Methods
    func editProfile() {
        // Handle profile editing logic here
        print("Edit Profile tapped")
    }
}
