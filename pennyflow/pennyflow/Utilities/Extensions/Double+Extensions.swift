//
//  Double+Extensions.swift
//  pennyflow
//
//  Created by Amine on 19/12/2024.
//

extension Double {
    /// Formats the double to a string:
    /// - If the decimal part is zero, it returns without decimals.
    /// - Otherwise, it returns with two decimal places.
    func formatted() -> String {
        if self.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", self) // No decimals
        } else {
            return String(format: "%.2f", self) // Two decimal places
        }
    }
}
