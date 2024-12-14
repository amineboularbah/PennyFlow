//
//  Login.swift
//  pennyflow
//
//  Created by Amine on 29/11/2024.
//

import SwiftUI

struct Registration: View {
    @Environment(\.presentationMode) var presentationMode // To handle dismissing
    @ObservedObject var viewModel: ProfileViewModel = ProfileViewModel()
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(spacing: 20) {
                    
                    AppLogo().padding(.top, .topInsets)
                    Spacer()
                    CustomTextField(placeholder: "Full name", text: $viewModel.name)
                    CustomTextField(placeholder: "Email", text: $viewModel.email)
                    CustomTextField(
                        placeholder: "Starting Balance", text: $viewModel.balance
                    )
                    .keyboardType(.decimalPad)
                    
                    // Use the CurrencySelector
                    CurrencySelector(selectedCurrency: $viewModel.selectedCurrency)
                    
                    PrimaryButton(
                        title: "Submit", action: viewModel.saveUserData,
                        isEnabled: viewModel.isFormValid)
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
            .onReceive(viewModel.$name) { _ in
                validateForm()
            }
            
            .onReceive(viewModel.$email) { _ in
                validateForm()
            }
            .onReceive(viewModel.$balance) { _ in
                validateForm()
            }
            .navigationDestination(isPresented: $viewModel.navigateToMainScreen) {
                MainScreen() // Replace with your main screen view
            }
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("OK", role: .cancel) {
                    viewModel.errorMessage = nil // Clear the error message after dismissing
                }
            }
            
        } .navigationBarBackButtonHidden(true)
        
    }

    // Validate the form fields
     private func validateForm() {
        viewModel.isFormValid = !viewModel.name.isEmpty
        && isValidEmail(viewModel.email)
        && !viewModel.balance.isEmpty
    }

    // Check for valid email format
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(
            with: email)
    }
}

struct Registration_Previews: PreviewProvider {
    static var previews: some View {
        Registration()
            .applyDefaultBackground()
    }
}
