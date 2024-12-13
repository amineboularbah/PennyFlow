//
//  Subscription.swift
//  pennyflow
//
//  Created by Amine on 7/12/2024.
//
import SwiftUI

struct Subscription: Codable, Identifiable {
    let id: Int // Use the id from JSON
    let name: String
    let description: String
    let price: Double?
    let date: String?
    let image: String
}


class SubscriptionData: ObservableObject {
    @Published var subscriptions: [Subscription] = []

    init() { // Remove `private` to allow manual initialization
        loadSubscriptions()
    }

    private func loadSubscriptions() {
        if let url = Bundle.main.url(forResource: "subscriptions", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decodedData = try JSONDecoder().decode([Subscription].self, from: data)
                self.subscriptions = decodedData
            } catch {
                print("Error loading or decoding JSON: \(error)")
            }
        } else {
            print("JSON file not found.")
        }
    }
}
