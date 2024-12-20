//
//  BudgetsView.swift
//  pennyflow
//
//  Created by Amine on 7/12/2024.
//
import SwiftUI

struct BudgetsView: View {
    @EnvironmentObject var categoryViewModel: CategoryViewModel  // Access category data from the ViewModel
    @EnvironmentObject var appViewModel: AppViewModel
    @State private var segments: [ProgressSegment] = []  // Segments for CircularProgressView
    @State private var totalBudget: Double = 0  // Total of maxBudget
    @State private var spentAmount: Double = 0  // Total spent
    @State private var navigateToSettings = false

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 16) {
                    // Header
                    CustomAppBar(
                        navigateToSettings: $navigateToSettings,
                        title: "Spending & Budgets")

                    // Circular Progress View
                    CircularProgressView(
                        segments: $segments,
                        totalBudget: categoryViewModel.totalBudget(),
                        spentAmount: categoryViewModel.totalSpent()
                    )
                    .onAppear {
                        loadCategoriesIfNeeded()  // Load categories if not already loaded
                        updateSegments()  // Update progress view data
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
            }
            .applyDefaultBackground()
            .navigationDestination(
                isPresented: $navigateToSettings
            ) {
                SettingsView()
            }
            .onDisappear {
                print("Cleanup or perform action here when dismissed.")
                if appViewModel.forceShowBudget {
                    appViewModel.forceShowBudget = false
                }
            }
        }
    }

    private var scrollableCategoriesView: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(categoryViewModel.categories) { category in
                    BudgetCategoryRowView(category: category)
                }
            }

            // Add New Category Button
            OutlinedDashButton(
                title: "Add New Category",
                onTap: {
                    // Example action to add a new category
                })
        }
        .padding(.horizontal)
    }

    // MARK: - Load Categories If Needed
    private func loadCategoriesIfNeeded() {
        categoryViewModel.fetchCategories()
    }

    // MARK: - Update Segments
    private func updateSegments() {
        let categories = categoryViewModel.categories

        // Calculate the total budget and total spent amount
        totalBudget = categories.reduce(0) { $0 + $1.budget }
        spentAmount = categories.reduce(0) { $0 + $1.totalAmountSpent }

        // Map categories to progress segments
        segments = categories.map { category in
            let progress = category.totalAmountSpent / totalBudget
            return ProgressSegment(
                color: Color(hex: category.color ?? "FFA699"),
                progress: progress)
        }
    }
}

struct BudgetsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Preview with mock ViewModel
            let mockCategoryViewModel = CategoryViewModel(
                context: PersistenceController.preview.container.viewContext,
                currentUser: nil
            )
            BudgetsView()
                .environmentObject(mockCategoryViewModel)  // Inject mock data
                .applyDefaultBackground()
        }
    }
}
