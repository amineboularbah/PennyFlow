//
//  AddSubscriptionView.swift
//  pennyflow
//
//  Created by Amine on 7/12/2024.
//
import SwiftUI

struct AddSubscriptionView: View {
    @State private var selectedPlatform: Int?
    @EnvironmentObject var subscriptionData: SubscriptionData
    
    var body: some View {
        VStack {
            Text("New")
                .appTextStyle(font: .bodyLarge, color: .gray30)
                .padding(.bottom)
            
            SubscriptionsGridView(selectedPlatform: $selectedPlatform)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensures the view fills the sheet
        .applyDefaultBackground() // Apply background color to the entire sheet
       
    }
}

struct AddSubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        let subs = SubscriptionData()
        AddSubscriptionView()
            .environmentObject(subs)
    }
}
