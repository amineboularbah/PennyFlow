//
//  AddSubscriptionView.swift
//  pennyflow
//
//  Created by Amine on 7/12/2024.
//
import SwiftUI

struct AddSubscriptionView: View {
    @EnvironmentObject var subscriptionData: SubscriptionsViewModel
    @State private var description: String = ""
    @State private var selectedPlatform: Int?
    @State private var price: Double = 0.00
    @State private var isEditingPrice: Bool = false  // Track if the price is being edited
    @State private var priceInput: String = ""  // Temporary input string for editing

    init() {
        // Use SwiftUI Color and convert it to UIColor
        let backgroundColor = UIColor(.gray70)  // Replace with your custom color name
        let titleColor = UIColor(.gray30)  // Replace with your custom color name

        // Customize the navigation bar appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()  // Makes the background opaque
        appearance.backgroundColor = backgroundColor  // Use converted UIColor
        appearance.titleTextAttributes = [.foregroundColor: titleColor]  // Title color
        appearance.largeTitleTextAttributes = [.foregroundColor: titleColor]  // Large title color

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        NavigationView {
            VStack {
                SubscriptionsGridView(selectedPlatform: $selectedPlatform)

                VStack {
                    
                    CustomTextField(placeholder: "Description", text: $description)
                    
                    PriceSetupView(
                        price: $price, isEditingPrice: $isEditingPrice,
                        priceInput: $priceInput)
                    Spacer()
                    PrimaryButton(title: "Add Subscription", action: handleAddSubscription)
                    Spacer()
                }.padding()
                
            }
            .applyDefaultBackground()
                .navigationTitle("New Subscription")
                .navigationBarTitleDisplayMode(.inline)

        }

    }
    
    private func handleAddSubscription(){
        print("Add subscription logic is unimplemented")
    }
}

struct AddSubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        let subs = SubscriptionData()
        AddSubscriptionView()
            .environmentObject(subs)
            .applyDefaultBackground()
    }
}
