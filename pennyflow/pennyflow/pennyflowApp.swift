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
    @StateObject private var subscriptionData = SubscriptionData() // Create an instance at app launch
    
    var body: some Scene {
        WindowGroup {
            MainScreen()
                .preferredColorScheme(.dark)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(subscriptionData)
                .background(Color.gray80)
                
        }
    }
}
