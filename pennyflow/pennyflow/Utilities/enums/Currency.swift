//
//  Currency.swift
//  pennyflow
//
//  Created by Amine on 29/11/2024.
//

enum Currency: String, CaseIterable {
    case usd = "USD"
    case eur = "EUR"
    case gbp = "GBP"
    case mad = "MAD"

    var symbol: String {
        switch self {
        case .usd: return "$"
        case .eur: return "€"
        case .gbp: return "£"
        case .mad: return "د.م"
        }
    }
}
