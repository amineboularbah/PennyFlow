//
//  MainScreen.swift
//  pennyflow
//
//  Created by Amine on 6/12/2024.
//
import SwiftUI

struct MainScreen: View {
    @Environment(\.managedObjectContext) var context
    @State private var selectedTab: Int = 0
    @State private var isAddingSubscription = false  // Push to Add Subscription page

    var body: some View {
        NavigationStack {
            ZStack {
                // Show the selected page
                TabView(selection: $selectedTab) {
                    HomeView().tag(0)
                    BudgetsView().tag(1)
                    CalendarView(context: context).tag(2)
                    CardsView().tag(3)
                }.padding(.bottom, .bottomInsets)
                GradientLayer()
                // Floating Bottom Navigation Bar
                FloatingBottomNavigationBar(
                    selectedTab: $selectedTab,
                    isAddingSubscription: $isAddingSubscription
                )
                .edgesIgnoringSafeArea(.bottom)  // Allow the bar to float at the bottom
            }
            .applyDefaultBackground()
            .navigationDestination(
                isPresented: $isAddingSubscription
            ) {
                AddSubscriptionView()
            }

        }
        .navigationBarBackButtonHidden(true)  // Hide the navigation bar
        
    }
}

extension NavigationItem: Identifiable {}

struct NavigationItem {
    let id: Int
    let activeIcon: String
    let inactiveIcon: String
    let label: String
}

// Preview
struct MainScreenPreview: PreviewProvider {
    static var previews: some View {
        MainScreen().applyDefaultBackground()
    }
}
