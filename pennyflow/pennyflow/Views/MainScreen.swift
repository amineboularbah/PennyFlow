//
//  MainScreen.swift
//  pennyflow
//
//  Created by Amine on 6/12/2024.
//
import SwiftUI
struct MainScreen: View {
    @State private var selectedTab: Int = 0
    @State private var isAddingSubscription = false  // Push to Add Subscription page

    var body: some View {
        NavigationView {
            ZStack {
                // Show the selected page
                TabView(selection: $selectedTab) {
                    HomeView().tag(0)
                    BudgetsView().tag(1)
                    CalendarView().tag(2)
                    CardsView().tag(3)
                }

                // Black to Transparent Gradient at the Bottom
                GradientLayer()

                // Floating Bottom Navigation Bar
                FloatingBottomNavigationBar(selectedTab: $selectedTab, isAddingSubscription: $isAddingSubscription)
                .edgesIgnoringSafeArea(.bottom)  // Allow the bar to float at the bottom
            }
            .applyDefaultBackground()
        }
        .navigationBarBackButtonHidden(true)  // Hide the navigation bar
        .sheet(
            isPresented: $isAddingSubscription
        ) {
            AddSubscriptionView()  // Show Add Subscription page
        }
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
        let subs = SubscriptionData()
        MainScreen()
            .environmentObject(subs)
    }
}


struct GradientLayer: View {
    var body: some View {
        VStack {
            Spacer()
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]),
                startPoint: .bottom,
                endPoint: .top
            )
            .frame(height: 120) // Adjust as needed
            .ignoresSafeArea(edges: .bottom)
        }
    }
}
