//
//  pennyflowApp.swift
//  pennyflow
//
//  Created by Amine on 29/11/2024.
//

import SwiftUI

@main
struct pennyflowApp: App {
    // Initialize the Persistence Controller and AppViewModel
    let persistenceController = PersistenceController.shared
    @StateObject private var appViewModel = AppViewModel()

    var body: some Scene {
        WindowGroup {
            // Conditionally show the appropriate screen based on login status
            if appViewModel.isUserLoggedIn {
                MainScreen() // Navigate to MainScreen if logged in
                    .preferredColorScheme(.dark)
                    .environmentObject(appViewModel)
                    .environmentObject(
                        SubscriptionsViewModel(
                            context: persistenceController.container.viewContext
                        )
                    )
                    .environment(
                        \.managedObjectContext,
                        persistenceController.container.viewContext
                    )
                    .background(Color.gray80)
            } else {
                Welcome() // Navigate to Welcome screen if not logged in
                    .preferredColorScheme(.dark)
                    .environmentObject(appViewModel)
                    .environmentObject(
                        SubscriptionsViewModel(
                            context: persistenceController.container.viewContext
                        )
                    )
                    .environment(
                        \.managedObjectContext,
                        persistenceController.container.viewContext
                    )
                    .background(Color.gray80)
            }
        }
    }
}
