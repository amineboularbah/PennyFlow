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
    let categoryName: String?
    let dueDate: Date?

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case icon = "image"         // Map "image" in JSON to "icon" in DTO
        case desc = "description"  // Map "description" in JSON to "desc" in DTO
        case startDate
        case reminder
        case categoryName
        case dueDate
    }
}
