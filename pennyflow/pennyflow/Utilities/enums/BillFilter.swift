//
//  BillFilter.swift
//  pennyflow
//
//  Created by Amine on 20/12/2024.
//


enum BillFilter: String, CaseIterable {
    case month = "This Month"
    case threeMonths = "Next 3 Months"
    case sixMonths = "Next 6 Months"
    case year = "This Year"

    // Get the time interval in months for each filter
    var monthsInterval: Int {
        switch self {
        case .month: return 1
        case .threeMonths: return 3
        case .sixMonths: return 6
        case .year: return 12
        }
    }
}
