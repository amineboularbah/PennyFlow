//
//  AddSubscriptionViewModel.swift
//  pennyflow
//
//  Created by Amine on 18/12/2024.
//

import CoreData
import Foundation

class AddSubscriptionViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var description: String = ""
    @Published var price: Double = 0.0
    @Published var priceInput: String = ""
    @Published var billingFrequency: Frequency = .monthly
    @Published var selectedPlatform: Subscription?
    @Published var selectedDate: Date = Date() // Default to today
    @Published var isFormValid: Bool = false
    @Published var showDatePicker: Bool = false
    @Published var errorMessage: String?
    @Published var showCategoryPicker: Bool = false
    @Published var selectedCategory: Category? = nil

    private let context: NSManagedObjectContext
    private let subscriptionService: SubscriptionService
    private let currentUser: User?

    // MARK: - Initializer
    init(context: NSManagedObjectContext, currentUser: User?) {
        self.context = context
        self.subscriptionService = SubscriptionService.shared
        self.currentUser = currentUser
    }

    // MARK: - Validation Methods
    func validateForm() {
        if description.isEmpty {
            errorMessage = "Description cannot be empty."
        } else if price <= 0 {
            errorMessage = "Price must be greater than 0."
        } else if selectedPlatform == nil {
            errorMessage = "Please select a platform."
        } else if selectedCategory == nil {
            errorMessage = "Please select a category."
        } else if selectedDate > Date() {
            errorMessage = "Start date cannot be in the future."
        } else {
            errorMessage = nil // No errors
        }
        
        isFormValid = errorMessage == nil
    }
    
    // MARK: - Helper Method for Month Name
    func monthName(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter.string(from: date)
    }
    
    
    func addSubscription() {
        do {
            guard isFormValid else {
                throw ValidationError.invalidForm
            }
            
            // Ensure current user exists
            guard let user = currentUser else {
                throw ValidationError.userNotFound
            }
            
            // Attempt to save subscription
            try SubscriptionService.shared.saveSubscription(
                user: user,
                platform: selectedPlatform,
                description: description,
                price: price,
                startDate: selectedDate,
                freaquency: billingFrequency,
                context: PersistenceController.shared.container.viewContext
            )
            
            // Clear error message on success
            errorMessage = nil
            
        } catch ValidationError.invalidForm {
            errorMessage = ValidationError.invalidForm.errorDescription
        } catch ValidationError.userNotFound {
            errorMessage = ValidationError.userNotFound.errorDescription
        } catch {
            errorMessage = "An unexpected error occurred: \(error.localizedDescription)"
        }
    }

    // MARK: - Error Definitions
    enum ValidationError: LocalizedError {
        case formIncomplete
        case platformNotSelected
        case userNotFound
        case invalidForm

        var errorDescription: String? {
            switch self {
            case .formIncomplete:
                return "All fields are required to add a subscription."
            case .platformNotSelected:
                return "Please select a platform."
            case .userNotFound:
                return "Current user not found. Please log in again."
            case .invalidForm:
                return "Please fill out all fields correctly before proceeding."
            }
        }
    }
}
