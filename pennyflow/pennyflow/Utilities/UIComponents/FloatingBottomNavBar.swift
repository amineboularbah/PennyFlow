//
//  FloatingBottomNavBar.swift
//  pennyflow
//
//  Created by Amine on 6/12/2024.
//
import SwiftUI

struct FloatingArcBottomNavBar: View {
    @State private var selectedTab: Int = 0
    
    let navigationItems: [NavigationItem] = [
        NavigationItem(id: 0, activeIcon: "home", inactiveIcon: "home", label: "Home"),
        NavigationItem(id: 1, activeIcon: "budgets", inactiveIcon: "budgets", label: "Budgets"),
        NavigationItem(id: 2, activeIcon: "calendar", inactiveIcon: "calendar", label: "Calendar"),
        NavigationItem(id: 3, activeIcon: "creditcards", inactiveIcon: "creditcards", label: "Cards"),
        
    ]

    var body: some View {
        ZStack {

            // Floating Bottom Navigation Bar
            VStack {
                Spacer()
                ZStack {
                    // Custom Arc Shape with Circular Edges
                    ArcBackground()
                        .fill(Color.gray60)
                        .shadow(
                            color: .black.opacity(0.2), radius: 10, x: 0, y: 5
                        )
                        .frame(height: 64)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                        ) // Applies rounded edges
                        .padding(.horizontal, 20)

                    // Buttons
                    HStack(spacing: 40) {
                        ForEach(navigationItems.prefix(2)) { item in
                            Button(action: {
                                selectedTab = item.id
                            }) {
                               
                                    Image(selectedTab == item.id ? item.activeIcon : item.inactiveIcon)
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(selectedTab == item.id ? .white : .gray30)
                              
                                
                            }
                            .frame(maxWidth: .infinity) // Equal spacing for all items
                            
                        }
                        
                        Spacer() // this should add space between the icons in middle to leave space for the button
                        
                        ForEach(navigationItems.suffix(2)) { item in
                            Button(action: {
                                selectedTab = item.id
                            }) {
                             
                                    Image(selectedTab == item.id ? item.activeIcon : item.inactiveIcon)
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(selectedTab == item.id ? .white : .gray30)
                              
                            }
                            .frame(maxWidth: .infinity) // Equal spacing for all items
                            
                        }
                    }
                    .padding(.horizontal, 40)

                    // Center Button
                  Button(action: {
                        // Add action for center button
                        print("Center button tapped")
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 60, height: 60)
                                .shadow(color: .secondary50.opacity(0.5), radius: 10, x: 0, y: 5)
                            Image("plus")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                        }
                    }
                    .offset(y: -20) // Floating above the navigation bar
                }
            }
            .edgesIgnoringSafeArea(.bottom)  // Allow the bar to float at the bottom
        }
        .padding(.bottom, 10)
        .applyDefaultBackground()
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
struct FloatingArcBottomNavBar_Previews: PreviewProvider {
    static var previews: some View {
        FloatingArcBottomNavBar()
    }
}
