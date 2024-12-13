//
//  CircularProgressView.swift
//  pennyflow
//
//  Created by Amine on 9/12/2024.
//

import SwiftUI

struct CircularProgressView: View {
    var segments: [ProgressSegment] // Dynamic segments
    var totalBudget: Double         // Total budget value
    var spentAmount: Double         // Total spent amount
    private let circleSize: Double = 290.0
    private let circleRotationDegree: Double = 180
    
    var body: some View {
        ZStack {
            staticProgressArc
            // Draw each segment
            ForEach(0..<segments.count, id: \.self) { index in
                let startAngle = startAngle(for: index)
                let endAngle = endAngle(for: index)

                Circle()
                    .trim(from: 0, to: endAngle) // Use the top half of the circle
                    .stroke(
                        segments[index].color,
                        style: StrokeStyle(
                            lineWidth: 15,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(startAngle)) // Rotate segment into position
                    .frame(width: 200, height: 200)       // Adjust the circle size
                    .shadow(color: segments[index].color.opacity(0.6), radius: 10)
            }

            // Center Text
            VStack(spacing: 8) {
                Text("$\(String(format: "%.2f", spentAmount))")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)

                Text("of $\(String(format: "%.2f", totalBudget)) budget")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }

    // Calculate the starting angle for each segment
    private func startAngle(for index: Int) -> Double {
        let totalProgress = segments[..<index].reduce(0) { $0 + $1.progress }
        return 180 + totalProgress * 180
    }
    
    private func endAngle(for index: Int) -> Double {
        let totalProgress = segments[..<index].reduce(0) { $0 + $1.progress }
        print(totalProgress)
        print(segments[index].progress)
        return segments[index].progress / 2
    }
    
    // Static Progress Arc
    private var staticProgressArc: some View {
        Circle()
            .trim(from: 0, to: 0.5)  // Show only the top 50% of the circle
            .stroke(
                Color.gray60.opacity(0.2),
                style: StrokeStyle(
                    lineWidth: 10,
                    lineCap: .round
                )
            )
            .rotationEffect(.degrees(circleRotationDegree))
            .frame(width: circleSize, height: circleSize)
    }
}

// Data Model for Each Segment
struct ProgressSegment {
    var color: Color    // Color of the segment
    var progress: Double // Progress proportion (e.g., 0.25 for 25%)
}

// Preview Example
struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(
            segments: [
                ProgressSegment(color: .orange, progress: 0.25), // 25% progress
                ProgressSegment(color: .purple, progress: 0.40), // 40% progress
                ProgressSegment(color: .green, progress: 0.15)   // 15% progress
            ],
            totalBudget: 2000.0,  // Total budget
            spentAmount: 820.97   // Total spent amount
        )
        .applyDefaultBackground() // Match dark theme
    }
}
