//
//  SubscriptionDTO.swift
//  pennyflow
//
//  Created by Amine on 14/12/2024.
//

import Foundation

struct SubscriptionDTO: Decodable {
    let id: UUID
    let name: String
    let price: Double
    let icon: String
    let desc: String
    let startDate: Date?
    let reminder: String?
    let categoryName: String? // Optional to map to Category later
}
