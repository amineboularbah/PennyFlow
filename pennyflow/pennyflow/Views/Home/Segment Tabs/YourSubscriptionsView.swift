import SwiftUI

struct YourSubscriptionsView: View {
    let subscriptions = [
        Subscription(id: 1, name: "Spotify", description: "Music streaming service", price: 5.99, date: "Jun 25", image: "spotify_logo"),
        Subscription(id: 2, name: "YouTube Premium", description: "Ad-free videos", price: 18.99, date: "Jun 25", image: "youtube_logo"),
        Subscription(id: 3, name: "Microsoft OneDrive", description: "Cloud storage", price: 29.99, date: "Jun 25", image: "onedrive_logo")
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(subscriptions) { subscription in
                    SubscriptionRowView(subscription: subscription, showDate: false)
                }
            }
            .padding()
        }
    }
}

struct YourSubscriptionsView_Previews: PreviewProvider {
    static var previews: some View {
        YourSubscriptionsView()
    }
}
