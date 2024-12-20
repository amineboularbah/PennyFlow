//
//  PriceSetupView.swift
//  pennyflow
//
//  Created by Amine on 7/12/2024.
//

import SwiftUI

struct PriceSetupView: View {
    @Binding var price: Double  // Initial price
    @Binding var isEditingPrice: Bool  // Track if the price is being edited
    @Binding var priceInput: String  // Temporary input string for editing
    @FocusState private var isTextFieldFocused: Bool // To manage keyboard focus
    var body: some View {
        VStack {
            // Title
            Text("Monthly price")
                .appTextStyle(font: .headline8, color: .gray40)

            HStack {

                // Decrement button
                Button(action: {
                    if price > 0.99 { price -= 1.00 }  // Decrease price
                }) {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gray60.opacity(0.3))
                        .frame(width: 50, height: 50)
                        .overlay(
                            Image("minus")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.gray60)
                        )
                }
                Spacer()
                // Price Display (Editable)
                if isEditingPrice {
                    TextField("Enter Price", text: $priceInput)
                        .appTextStyle(font: .headline4)
                        .multilineTextAlignment(.center)
                        .keyboardType(.decimalPad)
                        .focused($isTextFieldFocused)  // Link to FocusState
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()  // Push the button to the right
                                Button("Done") {
                                    handlePriceSubmission()
                                    isTextFieldFocused = false  // Dismiss the keyboard
                                }
                            }
                        }
                        .onAppear {
                            priceInput = String(format: "%.2f", price)
                        }
                } else {
                    Text(String(format: "$%.2f", price))
                        .appTextStyle(font: .headline4)
                        .onTapGesture {
                            isEditingPrice = true  // Enable edit mode
                        }
                }

                Spacer()

                // Increment button
                Button(action: {
                    price += 1.00  // Increase price
                }) {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gray60.opacity(0.3))
                        .frame(width: 50, height: 50)
                        .overlay(
                            Image("plus")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.gray60)
                        )
                }
            }.padding(.horizontal)

            // Horizontal Divider
            Divider()
                .background(Color.gray70)
                .padding()

        }
      
    }
    
    // Handle Price Submission
    private func handlePriceSubmission() {
        if let newPrice = Double(priceInput), newPrice >= 0 {
            price = newPrice
        }
        isEditingPrice = false // Exit edit mode
    }
}

struct PriceSetupView_Previews: PreviewProvider {
    static var previews: some View {
        PriceSetupView(
            price: .constant(1.99), isEditingPrice: .constant(false),
            priceInput: .constant("1.99")
        )
        .previewLayout(.sizeThatFits)
        .applyDefaultBackground()
    }
}
