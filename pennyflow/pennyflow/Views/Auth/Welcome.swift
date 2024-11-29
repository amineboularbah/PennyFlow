//
//  Welcome.swift
//  pennyflow
//
//  Created by Amine on 29/11/2024.
//

import SwiftUI

struct Welcome: View {
    @State private var navigateToRegistration = false // Track navigation state
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("welcome_screen")
                    .resizable()
                    .scaledToFill()
                    .frame(width: .screenWidth, height: .screenHeight)
                
                VStack {
                    AppLogo()
                    Spacer()
                    VStack(alignment: .center) {
                        Text(
                            "Track your expenses, visualize your finances, and achieve your goals with ease."
                        )
                        .appTextStyle(font: .bodyLarge)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 30)
                        
                        PrimaryButton(
                            title: "Get Started", action: handleGetStarted
                        ).padding(.bottom, .bottomInsets)
                    }.padding()
                    
                }.padding(.top, .topInsets)
                
            }.ignoresSafeArea()
                .navigationDestination(isPresented: $navigateToRegistration) {
                    Registration() // Navigate to RegistrationPage
                }
        }
    }

    private func handleGetStarted() {
        print("Get Started button clicked")
        navigateToRegistration = true
    }
}
#Preview {
    Welcome()
}
