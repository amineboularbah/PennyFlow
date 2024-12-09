//
//  BugdetCategory.swift
//  pennyflow
//
//  Created by Amine on 9/12/2024.
//
import SwiftUI

struct BudgetCategory: Identifiable {
    let id = UUID()
    let name: String
    let spent: Double
    let maxBudget: Double
    let icon: String
    let progressColor: Color

    // Progress relative to maxBudget
    var progress: Double {
        spent / maxBudget
    }

    var spentText: String {
        "$\(String(format: "%.2f", spent))"
    }

    var remainingText: String {
        let remaining = maxBudget - spent
        return "$\(String(format: "%.2f", remaining)) left to spend"
    }
    var totalText: String {
        return "of $\(Int(maxBudget))"
    }
}
