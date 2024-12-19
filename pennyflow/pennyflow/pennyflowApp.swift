//
//  pennyflowApp.swift
//  pennyflow
//
//  Created by Amine on 29/11/2024.
//

import SwiftUI

@main
struct pennyflowApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var appViewModel = AppViewModel()
    @StateObject private var profileViewModel = ProfileViewModel()

    init() {
        // Initialize Core Data context
        let context = persistenceController.container.viewContext

        // Initialize subscriptions if needed
        SubscriptionService.shared.initializeSubscriptionsIfNeeded(context: context)

        // Initialize categories if needed
        CategoryService.shared.initializeCategoriesIfNeeded(context: context)
    }

    var body: some Scene {
        WindowGroup {
            if appViewModel.isUserLoggedIn {
                MainScreen()
                    .preferredColorScheme(.dark)
                    .environmentObject(appViewModel)
                    .environmentObject(
                        SubscriptionsViewModel(
                            context: persistenceController.container
                                .viewContext,
                            currentUser: profileViewModel.user
                        )
                    )
                    .environmentObject(
                        AddSubscriptionViewModel(
                            context: persistenceController.container
                                .viewContext,
                            currentUser: profileViewModel.user
                        )
                    )
                    .environmentObject(
                        CategoryViewModel(
                            context: persistenceController.container
                                .viewContext,
                            currentUser: profileViewModel.user
                        )
                    )
                    .environment(
                        \.managedObjectContext,
                        persistenceController.container.viewContext
                    )
                    .background(Color.gray80)

            } else {
                Welcome()
                    .preferredColorScheme(.dark)
                    .environmentObject(appViewModel)
                    .environmentObject(
                        SubscriptionsViewModel(
                            context: persistenceController.container
                                .viewContext,
                            currentUser: nil
                        )
                    )
                    .environmentObject(
                        AddSubscriptionViewModel(
                            context: persistenceController.container
                                .viewContext,
                            currentUser: nil
                        )
                    )
                    .environmentObject(
                        CategoryViewModel(
                            context: persistenceController.container
                                .viewContext,
                            currentUser: nil
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
