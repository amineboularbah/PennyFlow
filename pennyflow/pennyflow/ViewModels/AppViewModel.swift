//
//  AppViewModel.swift
//  pennyflow
//
//  Created by Amine on 14/12/2024.
//


import SwiftUI
import CoreData

class AppViewModel: ObservableObject {
    @Published var isUserLoggedIn: Bool = false // Tracks login state
    @Published var forceShowBudget: Bool = false

    private let userService: UserService

    init(userService: UserService = UserService()) {
        self.userService = userService
        checkUserLoginStatus()
    }

    // Check if user data exists in Core Data
    private func checkUserLoginStatus() {
        let user = userService.fetchUser()
        isUserLoggedIn = user != nil
    }
}
