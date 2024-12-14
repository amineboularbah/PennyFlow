//
//  Date+Extensions.swift
//  pennyflow
//
//  Created by Amine on 14/12/2024.
//

import Foundation

extension Date {
    func formattedDate(style: DateFormatter.Style = .medium) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}
