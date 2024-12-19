import CoreData
//
//  AddSubscriptionView.swift
//  pennyflow
//
//  Created by Amine on 7/12/2024.
//
import SwiftUI

struct AddSubscriptionView: View {
    @EnvironmentObject var viewModel: AddSubscriptionViewModel
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var context

    @State private var showCategorySelection = false

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack {
                    // Subscription Platform Grid
                    SubscriptionsGridView(
                        selectedPlatform: $viewModel.selectedPlatform
                    )
                    .onChange(of: viewModel.selectedPlatform) { _ in
                        viewModel.validateForm()
                    }

                    ScrollView {
                        VStack {

                            // Description Field
                            CustomTextField(
                                placeholder: "Description",
                                text: $viewModel.description
                            )
                            .onChange(of: viewModel.description) { _ in
                                viewModel.validateForm()
                            }
                            // Horizontal Divider
                            Divider()
                                .background(Color.gray70)
                                .padding(.vertical, 8)
                            // Category Selection
                            CategorySelectionRow(
                                title: "Category",
                                onTap: {
                                    viewModel.showCategoryPicker = true
                                },
                                selectedValue: viewModel.selectedCategory?.name
                                    ?? "Select Category")
                            // Horizontal Divider
                            Divider()
                                .background(Color.gray70)
                                .padding(.vertical, 8)
                            // Starting Date Selection
                            CategorySelectionRow(
                                title: "Starting Date",
                                onTap: {
                                    viewModel.showDatePicker = true
                                },
                                selectedValue:
                                    viewModel.selectedDate.formattedDate()
                            )
                            .sheet(isPresented: $viewModel.showDatePicker) {
                                StartingDatePickerView()
                            }
                            .sheet(isPresented: $viewModel.showCategoryPicker) {
                                CategorySelectionView(
                                    selectedCategory: $viewModel
                                        .selectedCategory)
                            }

                            // Horizontal Divider
                            Divider()
                                .background(Color.gray70)
                                .padding(.vertical, 8)

                            // Frequency Picker
                            VStack(alignment: .leading, spacing: 0) {
                                HStack {
                                    Text("Billing Frequency").appTextStyle(
                                        font: .headline7, color: .gray50
                                    )
                                    Spacer()
                                }
                                Picker(
                                    "", selection: $viewModel.billingFrequency
                                ) {
                                    ForEach(
                                        Frequency
                                            .allCases, id: \.self
                                    ) { frequency in
                                        Text(frequency.rawValue.capitalized)
                                            .tag(frequency)
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .padding(.vertical)
                            }
                            // Horizontal Divider
                            Divider()
                                .background(Color.gray70)
                                .padding(.vertical, 8)
                            // Price Setup
                            PriceSetupView(
                                price: $viewModel.price,
                                isEditingPrice: .constant(false),
                                priceInput: $viewModel.priceInput
                            )
                            .onChange(of: viewModel.price) { _ in
                                viewModel.validateForm()
                            }

                            // Error Message
                            if let errorMessage = viewModel.errorMessage {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                                    .padding()
                            }
                            Spacer().frame(height: .bottomInsets * 2)

                        }.padding()
                    }
                }

                // Floating Button
                VStack {
                    Spacer()
                    // Add Subscription Button
                    PrimaryButton(
                        title: "Add Subscription",
                        action: handleAddSubscription,
                        isEnabled: viewModel.isFormValid
                    )
                    .padding(.horizontal, 20)
                    .padding(.bottom, .bottomInsets)
                }
            }

            .ignoresSafeArea()
            .applyDefaultBackground()

            .navigationBarTitleDisplayMode(.inline)
        }.navigationBarBackButtonHidden(true)  // Hide the navigation bar

    }

    private func handleAddSubscription() {
        print("Pressed")
        do {
            try viewModel.addSubscription()
            presentationMode.wrappedValue.dismiss()
        } catch {
            if let error = error as? AddSubscriptionViewModel.ValidationError {
                viewModel.errorMessage = error.errorDescription
            } else {
                viewModel.errorMessage =
                    "An unexpected error occurred. Please try again."
            }
        }
    }
}

// MARK: - Date Picker Sheet View
struct StartingDatePickerView: View {
    @EnvironmentObject var viewModel: AddSubscriptionViewModel

    var body: some View {
        VStack {
            // Graphical Date Picker
            DatePicker(
                "Select Date",
                selection: $viewModel.selectedDate,
                displayedComponents: [.date]
            )
            .datePickerStyle(GraphicalDatePickerStyle())
            .cornerRadius(15)
            .padding()
            .onChange(of: viewModel.selectedDate) { _ in
                viewModel.showDatePicker = false  // Close the sheet after selection
            }
            .tint(.secondaryC)
            .colorScheme(.dark)

            Spacer()
        }
        .frame(minHeight: 400)
        .background(Color.gray80)
        .presentationDetents([.height(400), .medium, .large])  // Fixed detents
    }
}

// MARK: - Reusable Category Selection Row
struct CategorySelectionRow: View {
    let title: String
    let onTap: () -> Void
    let selectedValue: String

    var body: some View {
        HStack {
            Text(title)
                .appTextStyle(
                    font: .headline7, color: .gray50)

            Spacer()

            Button(action: onTap) {
                HStack {

                    Text(selectedValue)
                        .appTextStyle(
                            font: .headline7, color: .gray30)
                    Image("next")
                        .resizable()
                        .frame(width: 12, height: 12)

                }
            }
        }
        .padding(.vertical, 10)
    }
}
