//
//  ArcBackgroundBNB.swift
//  pennyflow
//
//  Created by Amine on 7/12/2024.
//

import SwiftUI


// Custom Arc Background Shape
struct ArcBackground: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let cornerRadius: CGFloat = 10  // Radius for the rounded corners
        let buttonPadding: CGFloat = 10
        
        // Starting point of painting
        path.move(to: CGPoint(x: 0, y: 0))
        
        // Add a line from start point to 40% of the container width and remove the padding of the button to keep space between it and the BNB line
        path.addLine(to: CGPoint(x: rect.width * 0.4, y: 0))
        
        // Draw an arc from the point we left off to the corner radius height
        path.addArc(
            center: CGPoint(x: rect.width * 0.4 - buttonPadding, y: cornerRadius),
            radius: cornerRadius, startAngle: Angle(degrees: 270),
            endAngle: Angle(degrees: 0), clockwise: false)
        
        // Draw the half-circle arc from the last checkpoint
             path.addArc(
                center: CGPoint(x: rect.width * 0.5, y: cornerRadius), // Center at midpoint
                 radius: 35,
                 startAngle: Angle(degrees: 180),
                 endAngle: Angle(degrees: 0),
                 clockwise: true
             )
        
        // Once the cercle point ends, since last checkpoint is 0.4, and center of circle is half of the container width (0.5 * width), it means tha tend of the half circle will be at 0.6 of the container width, From there we create new arc towers the point we want (0.6 + padding of the width)
        path.addArc(
            center: CGPoint(x: rect.width * 0.6 + buttonPadding, y: cornerRadius),
            radius: cornerRadius,
            startAngle: Angle(degrees: 0),
            endAngle: Angle(degrees: 270), clockwise: false)
        
        // Now we're done with the hard part we can safely draw a line to the end of width and beginning if the height
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        
        // draw a line to the bottom right of the container
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        
        // Paint a straight line to the bottom left of the container
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        
        // Now we're done, we close the subpath
        path.closeSubpath()

        return path
    }
}
