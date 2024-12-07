//
//  MainScreen.swift
//  pennyflow
//
//  Created by Amine on 6/12/2024.
//

import SwiftUI

struct MainScreen: View {
    var body: some View {
        ZStack {
            // Main Content
            VStack {
                Spacer()
                Text("Main Content Goes Here")
                    .font(.title)
                    .foregroundColor(.primary)
                Spacer()
            }
            .edgesIgnoringSafeArea(.all) // Extend content to edges if needed
            
            // Bottom Navigation Bar
            VStack {
                Spacer() // Pushes the BNB to the bottom
                FloatingArcBottomNavBar()
            }
        }
        .edgesIgnoringSafeArea(.bottom)  // Allow the bar to float at the bottom
        .padding(.bottom, .bottomInsets)
        
    }
}

#Preview {
    MainScreen().applyDefaultBackground()
}
