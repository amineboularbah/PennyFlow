//
//  SubscriptionImageView.swift
//  pennyflow
//
//  Created by Amine on 7/12/2024.
//
import SwiftUI

struct SubscriptionImageView: View {
    let imageName: String // The image name in the asset catalog
    let subscriptionTitle: String // The title of the subscription
    let imageSize: CGFloat? // Image size (width and height)

    var body: some View {
        if UIImage(named: imageName) != nil {
            // Image exists, load it
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: imageSize ?? 70, height: imageSize ?? 70)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        } else {
            // Fallback: Display initials
            fallbackWithInitials(for: subscriptionTitle)
        }
    }

    // Fallback View with Initials
    @ViewBuilder
    private func fallbackWithInitials(for title: String) -> some View {
        let initials = extractInitials(from: title)
        ZStack {
            RoundedRectangle(cornerRadius: 20) // Square with rounded corners
                .fill(Color.gray.opacity(0.3))
                .frame(width: imageSize, height: imageSize)

            Text(initials)
                .font(.system(size: (imageSize ?? 70) / 3, weight: .bold))
                .foregroundColor(.white)
        }
    }

    // Helper to Extract Initials
    private func extractInitials(from title: String) -> String {
        let words = title.split(separator: " ") // Split title into words
        if words.count > 1 {
            let firstInitial = words[0].prefix(1) // First letter of first word
            let secondInitial = words[1].prefix(1) // First letter of second word
            return "\(firstInitial)\(secondInitial)".uppercased()
        } else {
            // Single word, return the first letter
            return String(title.prefix(1)).uppercased()
        }
    }
}
