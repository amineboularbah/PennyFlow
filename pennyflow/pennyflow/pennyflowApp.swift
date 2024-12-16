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
                            context: persistenceController.container.viewContext
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
                            context: persistenceController.container.viewContext
                        )
                    )
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .background(Color.gray80)
                    
            }
        }
    }
}
