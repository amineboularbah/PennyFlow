import SwiftUI

struct YourSubscriptionsView: View {
    let subscriptions = [
        Subscription(id: 1, name: "Spotify", price: "$5.99", date: "Jun 25"),
        Subscription(id: 2, name: "YouTube Premium", price: "$18.99", date: "Jun 25"),
        Subscription(id: 3, name: "Microsoft OneDrive", price: "$29.99", date: "Jun 25")
    ]

    var body: some View {
        VStack(spacing: 8) {
            ForEach(subscriptions) { subscription in
                SubscriptionRowView(subscription: subscription, showDate: false)
            }
        }
        .padding()
    }
}

struct YourSubscriptionsView_Previews: PreviewProvider {
    static var previews: some View {
        YourSubscriptionsView()
    }
}