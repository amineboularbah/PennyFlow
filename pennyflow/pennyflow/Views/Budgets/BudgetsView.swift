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
            spent: 140,
            maxBudget: 400.0,
            icon: "auto_&_transport",
            progressColor: .secondaryG
        ),
        BudgetCategory(
            name: "Entertainment",
            spent: 375.00,
            maxBudget: 600.0,
            icon: "entertainment",
            progressColor: .secondary50
        ),
        BudgetCategory(
            name: "Security",
            spent: 500,
            maxBudget: 600.0,
            icon: "security",
            progressColor: .primary10
        ),
    ]
    var body: some View {
        VStack(spacing: 16) {
            // Header
            HStack {
                Spacer()
                Text("Spending & Budgets")
                    .appTextStyle(font: .bodyLarge, color: .gray30)
                Spacer()
                Button(action: {
                    print("Settings tapped")
                }) {
                    Image("settings")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.gray30)
                }
            }
            .padding(.horizontal)

            // Circular Progress View
            CircularProgressView(
                progress: 820.97 / 2000.0,
                valueText: "$82.97",
                subtitle: "of $2,000 budget"
            )
            .padding(.horizontal)

            // Status Banner
            StatusBannerView(message: "Your budgets are on track 👍")

            scrollableCategoriesView
            Spacer().frame(height: 0)

        }
        .applyDefaultBackground()
    }

    private var scrollableCategoriesView: some View {
        return ScrollView {
            VStack(spacing: 16) {
                ForEach(categories) { category in
                    BudgetCategoryRowView(category: category)
                }
            }
            .padding(.horizontal)

            // Add New Category Button
            AddCategoryButton()  // Ensure total height including padding is 84

        }
    }
}

struct AddCategoryButton: View {
    var body: some View {
        Button(action: {
            print("Add new category tapped")
        }) {
            HStack {
                Spacer()  // Push content to the center
                Text("Add new category")
                    .appTextStyle(font: .headline7, color: .gray30)
                Image("add")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 16, height: 16)
                    .foregroundColor(.gray30)
                Spacer()  // Push content to the center
            }
            .frame(height: 64)  // Set the inner content height
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(
                        Color.gray60,
                        style: StrokeStyle(
                            lineWidth: 1,
                            dash: [6]
                        ))
            )
        }
        .padding(.horizontal)  // Adds padding on the sides

        .frame(height: 84)
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
