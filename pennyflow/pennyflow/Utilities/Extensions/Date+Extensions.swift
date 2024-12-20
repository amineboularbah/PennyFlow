//
//  Date+Extensions.swift
//  pennyflow
//
//  Created by Amine on 14/12/2024.
//

import Foundation

extension Date {
    func formattedDate(informal: Bool = false) -> String {
        let formatter = DateFormatter()
        
        if informal {
            // Use a casual, minimalist style
            formatter.dateFormat = "MMM d, yyyy"
        } else {
            // Use the default medium style
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
        }
        
        return formatter.string(from: self)
    }
}
