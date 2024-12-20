//
//  pennyflowApp.swift
//  pennyflow
//
//  Created by Amine on 29/11/2024.
//

import SwiftUI
import CoreData

@main
struct PennyflowApp: App {
    // MARK: - Properties
    private let persistenceController = PersistenceController.shared
    @StateObject private var appViewModel = AppViewModel()
    @StateObject private var profileViewModel = ProfileViewModel()
    
    // MARK: - Initializer
    init() {
        let context = persistenceController.container.viewContext
        initializeServices(context: context)
    }

    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            AppContentView()
                .preferredColorScheme(.dark)
                .environmentObject(appViewModel)
                .environmentObject(
                    SubscriptionsViewModel(
                        context: persistenceController.container.viewContext,
                        currentUser: profileViewModel.user
                    )
                )
                .environmentObject(
                    AddSubscriptionViewModel(
                        context: persistenceController.container.viewContext,
                        currentUser: profileViewModel.user
                    )
                )
                .environmentObject(
                    CategoryViewModel(
                        context: persistenceController.container.viewContext,
                        currentUser: profileViewModel.user
                    )
                )
                .environmentObject(
                    PlatformViewModel(
                        context: persistenceController.container.viewContext
                    )
                )
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .background(Color.gray80)
        }
    }
    
    // MARK: - Helper Methods
    /**
     Initializes services that require data loading on app launch.
     - Parameter context: Core Data context.
     */
    private func initializeServices(context: NSManagedObjectContext) {
        SubscriptionService.shared.initializeSubscriptionsIfNeeded(context: context)
        CategoryService.shared.initializeCategoriesIfNeeded(context: context)
        PlatformService.shared.initializePlatformsIfNeeded(context: context)
    }
}

struct AppContentView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        if appViewModel.isUserLoggedIn {
            MainScreen()
        } else {
            Welcome()
        }
    }
}
