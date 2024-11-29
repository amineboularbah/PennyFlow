//
//  Login.swift
//  pennyflow
//
//  Created by Amine on 29/11/2024.
//

import SwiftUI

struct Registration: View {
    @Environment(\.presentationMode) var presentationMode // To handle dismissing

    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var startingBalance: String = ""
    @State private var selectedCurrency: Currency = .usd  // Default selection
    @State private var isFormValid: Bool = false  // Track form validation
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
               
                AppLogo().padding(.top, .topInsets)
                Spacer()
                CustomTextField(placeholder: "First name", text: $firstName)
                CustomTextField(placeholder: "Last name", text: $lastName)
                CustomTextField(placeholder: "Email", text: $email)
                CustomTextField(
                    placeholder: "Starting Balance", text: $startingBalance
                )
                .keyboardType(.decimalPad)
                
                // Use the CurrencySelector
                CurrencySelector(selectedCurrency: $selectedCurrency)
                
                PrimaryButton(
                    title: "Submit", action: submitRegistration,
                    isEnabled: isFormValid)
                Button("Go Back", action: {
                    presentationMode.wrappedValue.dismiss()
                }).foregroundColor(.white)
                Spacer()
                
            }
            
            
        }
        .padding()
        .padding(.bottom, .bottomInsets)
        .ignoresSafeArea()
        .frame(width: .screenWidth, height: .screenHeight)
        .applyDefaultBackground()
        .onChange(of: firstName) { validateForm() }
        .onChange(of: lastName) { validateForm() }
        .onChange(of: email) { validateForm() }
        .onChange(of: startingBalance) { validateForm() }
        .navigationBarBackButtonHidden(true)

    }

    // Validate the form fields
    private func validateForm() {
        isFormValid =
            !firstName.isEmpty
            && !lastName.isEmpty
            && isValidEmail(email)
            && !startingBalance.isEmpty
    }

    // Check for valid email format
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(
            with: email)
    }

    private func submitRegistration() {
        print("Registration Submitted:")
        print("First Name: \(firstName)")
        print("Last Name: \(lastName)")
        print("Email: \(email)")
        print("Starting Balance: \(startingBalance)")
        print(
            "Currency: \(selectedCurrency.rawValue) \(selectedCurrency.symbol)")
    }
}

#Preview {
    Registration().applyDefaultBackground()
}
