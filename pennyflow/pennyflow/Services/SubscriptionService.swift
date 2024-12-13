//
//  SubscriptionService.swift
//  pennyflow
//
//  Created by Amine on 13/12/2024.
//


class SubscriptionService {
    static func fetchSubscriptions() -> [Subscription] {
        // Mock data or fetch from a backend
        return [
            Subscription(id: 1, name: "Spotify", description: "Music", price: 5.99, date: "2024-01-08", image: "spotify_logo"),
            Subscription(id: 2, name: "YouTube Premium", description: "Videos", price: 18.99, date: "2024-01-08", image: "youtube_logo")
        ]
    }
}
