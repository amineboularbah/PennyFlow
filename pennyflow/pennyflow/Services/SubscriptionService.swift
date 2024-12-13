//
//  SubscriptionService.swift
//  pennyflow
//
//  Created by Amine on 13/12/2024.
//


class SubscriptionService {
    static func fetchSubscriptions() -> [Subscription] {
        // Mock data or fetch from a backend
        return  [
            Subscription(id: 1, name: "Spotify", description: "Music streaming service", price: 5.99, date: "Jun 25", image: "spotify_logo"),
            Subscription(id: 2, name: "YouTube Premium", description: "Ad-free videos", price: 18.99, date: "Jun 25", image: "youtube_logo"),
            Subscription(id: 3, name: "Microsoft OneDrive", description: "Cloud storage", price: 29.99, date: "Jun 25", image: "onedrive_logo")
        ]
    }
}
