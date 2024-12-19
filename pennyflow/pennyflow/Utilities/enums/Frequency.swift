//
//  Frequency.swift
//  pennyflow
//
//  Created by Amine on 18/12/2024.
//


    enum Frequency: String, CaseIterable {
        case daily, weekly, monthly, yearly
        // Custom string representation
        var toString: String {
            switch self {
            case .daily:
                return "Daily"
            case .weekly:
                return "Weekly"
            case .monthly:
                return "Monthly"
            case .yearly:
                return "Yearly"
            }
        }
    }
