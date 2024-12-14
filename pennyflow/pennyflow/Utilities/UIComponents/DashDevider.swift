//
//  Line.swift
//  pennyflow
//
//  Created by Amine on 14/12/2024.
//
import SwiftUI

struct DashDevider: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}
