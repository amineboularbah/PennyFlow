//
//  CircularProgressView.swift
//  pennyflow
//
//  Created by Amine on 9/12/2024.
//
import SwiftUI

struct CircularProgressView: View {
    @Binding var segments: [ProgressSegment] // Represents the progress bar segments
    @Binding var totalBudget: Double         // Total budget for the half-circle
    @Binding var spentAmount: Double         // Total spent amount

    // Constants
    private let circleSize: Double = 210.0 // Circle dimensions
    private let halfCircleDegrees: Double = 180 // Represents a half-circle

    var body: some View {
        ZStack {
            // Static Background Arc
            staticProgressArc
            
            // Dynamic Segments
            ForEach(0..<segments.count, id: \.self) { index in
                drawSegment(index: index)
            }
            
            // Center Text
            centerText
        }
    }

    // MARK: - Helper Methods

    // Draw a single segment
    private func drawSegment(index: Int) -> some View {
        let startAngle = startAngle(for: index) // Calculate starting position
        let endAngle = endAngle(for: index)     // Calculate segment length
        
        return Circle()
            .trim(from: 0, to: endAngle) // Draw only part of the circle
            .stroke(
                segments[index].color,   // Apply the segment's color
                style: StrokeStyle(
                    lineWidth: 12.5,    // Thickness
                    lineCap: .round     // Smooth, rounded edges
                )
            )
            .rotationEffect(.degrees(startAngle)) // Position the segment
            .frame(width: circleSize, height: circleSize) // Circle dimensions
            .shadow(color: segments[index].color.opacity(0.6), radius: 10) // Subtle glow
    }

    // Starting angle for a segment
    private func startAngle(for index: Int) -> Double {
        // Calculate total progress up to the current segment
        let totalProgress = segments[..<index].reduce(0) { $0 + $1.progress }
        
        // Start angle = Base rotation + cumulative progress scaled to the half-circle
        return halfCircleDegrees + totalProgress * halfCircleDegrees
    }
    
    // End angle for a segment
    private func endAngle(for index: Int) -> Double {
        // Proportion of the current segment mapped to the half-circle range
        return segments[index].progress / 2
    }

    // Static Background Arc
    private var staticProgressArc: some View {
        Circle()
            .trim(from: 0, to: 0.5) // Show only the top 50% of the circle
            .stroke(
                Color.gray60.opacity(0.2), // Static light gray arc
                style: StrokeStyle(
                    lineWidth: 10,      // Background arc thickness
                    lineCap: .round     // Smooth edges
                )
            )
            .rotationEffect(.degrees(halfCircleDegrees)) // Start from the top of the circle
            .frame(width: circleSize, height: circleSize) // Circle dimensions
    }

    // Center Text (Budget and Spent Amount)
    private var centerText: some View {
        VStack(spacing: 8) {
            // Spent Amount
            Text("$\(formattedAmount(spentAmount))")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.white)

            // Total Budget
            Text("of $\(formattedAmount(totalBudget)) budget")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }

    // Helper Function for Conditional Formatting
    private func formattedAmount(_ amount: Double) -> String {
        if amount.truncatingRemainder(dividingBy: 1) == 0 {
            // If the decimal part is zero, return without decimals
            return String(format: "%.0f", amount)
        } else {
            // Otherwise, return with two decimal places
            return String(format: "%.2f", amount)
        }
    }
}

// MARK: - Models

// Represents a single segment in the progress bar
struct ProgressSegment {
    var color: Color    // Segment color
    var progress: Double // Progress proportion (e.g., 0.25 for 25%)
}

// MARK: - Preview Example

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(
            segments: .constant([
                ProgressSegment(color: .orange, progress: 0.25), // 25% progress
                ProgressSegment(color: .purple, progress: 0.40), // 40% progress
                ProgressSegment(color: .green, progress: 0.15)   // 15% progress
            ]),
            totalBudget: .constant(2000.0),  // Total budget
            spentAmount: .constant(820.97)  // Total spent amount
        )
        .applyDefaultBackground() // Apply a dark background for preview
    }
}
