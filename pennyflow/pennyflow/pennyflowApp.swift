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
        // Initialize subscriptions if needed
        let context = persistenceController.container.viewContext
        SubscriptionService.shared.initializeSubscriptionsIfNeeded(context: context)
    }

    var body: some Scene {
        WindowGroup {
            if appViewModel.isUserLoggedIn {
                MainScreen()
                    .preferredColorScheme(.dark)
                    .environmentObject(appViewModel)
                    .environmentObject(
                        SubscriptionsViewModel(
                            context: persistenceController.container.viewContext,
                            currentUser: profileViewModel.user
                        )
                    )
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .background(Color.gray80)
                    
            } else {
                Welcome()
                    .preferredColorScheme(.dark)
                    .environmentObject(appViewModel)
                    .environmentObject(
                        SubscriptionsViewModel(
                            context: persistenceController.container.viewContext,
                            currentUser: nil
                        )
                    )
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .background(Color.gray80)
                    
            }
        }
    }
}
