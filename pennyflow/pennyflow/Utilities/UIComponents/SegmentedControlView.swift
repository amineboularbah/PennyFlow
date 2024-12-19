//
//  SegmentedControlView.swift
//  pennyflow
//
//  Created by Amine on 8/12/2024.
//

import SwiftUI

struct SegmentedControlView: View {
    @Binding var selectedTab: Int  // 0 for "Your subscriptions", 1 for "Upcoming bills"
    private let cornerRadius: Double = 16
    var body: some View {
        HStack(spacing: 8) {
            // Your Subscriptions Button
            // Upcoming Bills Button
            SecondaryButton(
                title: "Your Subscriptions",
                action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        selectedTab = 0
                    }

                }, cornerRadius: cornerRadius, height: 36, isFilled: selectedTab == 0,
                textColor: selectedTab == 0 ? .white : .gray30)
            // Upcoming Bills Button
            SecondaryButton(
                title: "Upcoming bills",
                action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        selectedTab = 1
                    }

                }, cornerRadius: cornerRadius, height: 36, isFilled: selectedTab == 1,
                textColor: selectedTab == 1 ? .white : .gray30)
        }
        .frame(height: 50)
        .padding(.horizontal, 10)
        .background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color.grayC)  // Background for the entire segment control
        )
        .padding(.horizontal, 16)  // Optional padding for spacing
    }
}

struct SegmentedControlView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedControlView(selectedTab: .constant(0))
            .background(Color.black.edgesIgnoringSafeArea(.all))  // Match dark mode background
    }
}
