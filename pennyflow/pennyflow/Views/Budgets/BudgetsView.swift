//
//  BudgetsView.swift
//  pennyflow
//
//  Created by Amine on 7/12/2024.
//
import SwiftUI

struct BudgetsView: View {
    let categories: [BudgetCategory] = [
        BudgetCategory(
            name: "Auto & Transport",
            spent: 200,
            maxBudget: 400.0,
            icon: "auto_&_transport",
            progressColor: .secondaryG
        ),
        BudgetCategory(
            name: "Entertainment",
            spent: 600.00,
            maxBudget: 600.0,
            icon: "entertainment",
            progressColor: .secondary50
        ),
        BudgetCategory(
            name: "Security",
            spent: 600,
            maxBudget: 600.0,
            icon: "security",
            progressColor: .primary10
        ),
    ]
    
    @State private var segments: [ProgressSegment] = [] // Segments for CircularProgressView
    @State private var totalBudget: Double = 0          // Total of maxBudget
    @State private var spentAmount: Double = 0          // Total spent
    @State private var navigateToSettings = false

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 16) {
                    // Header
                    CustomAppBar(navigateToSettings: $navigateToSettings, title: "Spending & Budgets")
                    
                    // Circular Progress View
                    CircularProgressView(
                        segments: $segments,
                        totalBudget: $totalBudget,
                        spentAmount: $spentAmount
                    )
                    .onAppear {
                        updateSegments() // Reassign segments when the view appears
                    }
                    .padding(.horizontal)
                    Spacer()
                }
                
                
                // Status Banner
                VStack(spacing: 16) {
                    Spacer().frame(height: .heightPer(per: 20))
                    StatusBannerView(message: "Your budgets are on track 👍")
                    
                    
                    scrollableCategoriesView
                    Spacer().frame(height: 0)
                }
            }.applyDefaultBackground()
                .navigationDestination(
                    isPresented: $navigateToSettings
                ) {
                    SettingsView()
                }
        }
    }

    private var scrollableCategoriesView: some View {
        return ScrollView {
            VStack(spacing: 16) {
                ForEach(categories) { category in
                    BudgetCategoryRowView(category: category)
                }
            }
            

            // Add New Category Button
            OutlinedDashButton(title: "Add New Category", onTap: {
                
            })  // Ensure total height including padding is 84

        }.padding(.horizontal)
    }
    
    // MARK: - Update Segments
    private func updateSegments() {
        // Calculate the total budget and total spent amount
        totalBudget = categories.reduce(0) { $0 + $1.maxBudget }
        spentAmount = categories.reduce(0) { $0 + $1.spent }

        // Map categories to progress segments
        segments = categories.map { category in
            let progress = category.spent / totalBudget
            return ProgressSegment(color: category.progressColor, progress: progress)
        }
    }
}

struct BudgetsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Preview for Default Configuration
            BudgetsView()
                .applyDefaultBackground()

        }
    }
}
