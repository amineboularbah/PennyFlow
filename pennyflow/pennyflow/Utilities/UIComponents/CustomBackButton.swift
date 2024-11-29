//
//  CustomBackButton.swift
//  pennyflow
//
//  Created by Amine on 29/11/2024.
//


import SwiftUI

struct CustomBackButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "chevron.left") // Use SF Symbol for back arrow
                    .font(.system(size: 18, weight: .medium))
                Text("Back")
                    .font(.system(size: 18, weight: .medium))
            }
            .foregroundColor(.white) // Customize color
        }
    }
}
