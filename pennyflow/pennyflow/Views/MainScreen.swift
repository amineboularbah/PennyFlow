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

    let navigationItems: [NavigationItem] = [
        NavigationItem(
            id: 0, activeIcon: "home", inactiveIcon: "home", label: "Home"),
        NavigationItem(
            id: 1, activeIcon: "budgets", inactiveIcon: "budgets",
            label: "Budgets"),
        NavigationItem(
            id: 2, activeIcon: "calendar", inactiveIcon: "calendar",
            label: "Calendar"),
        NavigationItem(
            id: 3, activeIcon: "creditcards", inactiveIcon: "creditcards",
            label: "Cards"),

    ]

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
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))  // Disable default tab bar

                // Floating Bottom Navigation Bar
                VStack {
                    Spacer()
                    ZStack {
                        // Custom Arc Shape with Circular Edges
                        ArcBackground()
                            .fill(Color.gray60)
                            .shadow(
                                color: .black.opacity(0.2), radius: 10, x: 0,
                                y: 5
                            )
                            .frame(height: 64)
                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: 20, style: .continuous)
                            )  // Applies rounded edges
                            .padding(.horizontal, 20)

                        // Buttons
                        HStack(spacing: 40) {
                            ForEach(navigationItems.prefix(2)) { item in
                                Button(action: {
                                    selectedTab = item.id
                                }) {

                                    Image(
                                        selectedTab == item.id
                                            ? item.activeIcon
                                            : item.inactiveIcon
                                    )
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(
                                        selectedTab == item.id
                                            ? .white : .gray30)

                                }
                                .frame(maxWidth: .infinity)  // Equal spacing for all items

                            }

                            Spacer()  // this should add space between the icons in middle to leave space for the button

                            ForEach(navigationItems.suffix(2)) { item in
                                Button(action: {
                                    selectedTab = item.id
                                }) {

                                    Image(
                                        selectedTab == item.id
                                            ? item.activeIcon
                                            : item.inactiveIcon
                                    )
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(
                                        selectedTab == item.id
                                            ? .white : .gray30)

                                }
                                .frame(maxWidth: .infinity)  // Equal spacing for all items

                            }
                        }
                        .padding(.horizontal, 40)

                        // Center Button
                        Button(action: {
                            isAddingSubscription = true

                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color.secondaryC)
                                    .frame(width: 55, height: 55)
                                    .shadow(
                                        color: .secondary50.opacity(0.5),
                                        radius: 10, x: 0, y: 5)
                                Image("plus")
                                    .resizable()
                                    .frame(width: 45, height: 45)
                                    .foregroundColor(.white)
                            }
                        }
                        .offset(y: -20)  // Floating above the navigation bar
                    }.padding(.bottom, .bottomInsets )
                }
                .edgesIgnoringSafeArea(.bottom)  // Allow the bar to float at the bottom
            }.ignoresSafeArea()
            
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
