//
//  Category+Extensions.swift
//  pennyflow
//
//  Created by Amine on 19/12/2024.
//

extension Category {
    // Entity name on CoreData
    var entityName: String {
        return "Category"
    }
    // Computed property to calculate the total amount dynamically
    var totalAmount: Double {
        guard let subscriptions = subscriptions as? Set<Subscription> else {
            return 0.0
        }
        return subscriptions.reduce(0) { $0 + $1.price }
    }
    
    var remainingAmount: Double {
        return budget - totalAmount
    }
    
    // Progress relative to the budget
    var progress: Double {
        return totalAmount / budget
    }
}
