//
//  SubscriptionDTO 2.swift
//  pennyflow
//
//  Created by Amine on 20/12/2024.
//


import Foundation

struct PlatformDTO: Decodable {
    let id: UUID
    let name: String
    let image: String
    let desc: String

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case desc = "description"  // Map "description" in JSON to "desc" in DTO

    }
}
