//
//  CircularProgressView.swift
//  pennyflow
//
//  Created by Amine on 9/12/2024.
//


import SwiftUI

struct CircularProgressView: View {
    var progress: Double
    var valueText: String
    var subtitle: String

    var body: some View {
        ZStack {
            // Background Arc
            Circle()
                .trim(from: 0, to: 1)
                .stroke(
                    Color.gray.opacity(0.2),
                    style: StrokeStyle(lineWidth: 15, lineCap: .round)
                )
                .rotationEffect(.degrees(130))
                .frame(width: 200, height: 200)

            // Foreground Progress Arc
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.green,
                    style: StrokeStyle(lineWidth: 15, lineCap: .round)
                )
                .rotationEffect(.degrees(130))
                .frame(width: 200, height: 200)

            // Inner Content
            VStack(spacing: 8) {
                Text(valueText)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}
