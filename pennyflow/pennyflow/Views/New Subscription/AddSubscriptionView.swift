//
//  AddSubscriptionView.swift
//  pennyflow
//
//  Created by Amine on 7/12/2024.
//
import SwiftUI

struct AddSubscriptionView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Add Subscription")
                .font(.largeTitle)
                .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensures the view fills the sheet
        .applyDefaultBackground() // Apply background color to the entire sheet
        .edgesIgnoringSafeArea(.all) // Extend background to edges if needed
    }
}
