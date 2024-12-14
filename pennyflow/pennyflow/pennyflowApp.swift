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

    var body: some Scene {
        WindowGroup {
            Welcome()
                .preferredColorScheme(.dark)
                .environmentObject(
                    SubscriptionsViewModel(
                        context: persistenceController.container.viewContext)
                )
                .environment(
                    \.managedObjectContext,
                    persistenceController.container.viewContext
                )
                .background(Color.gray80)

        }
    }
}
