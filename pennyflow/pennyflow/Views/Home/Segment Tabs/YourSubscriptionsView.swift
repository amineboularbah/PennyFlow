import SwiftUI

struct YourSubscriptionsView: View {
    @State private var subscriptions: [Subscription] = []

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(subscriptions) { subscription in
                    SubscriptionRowView(subscription: subscription, showDate: false)
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            subscriptions = SubscriptionService.fetchSubscriptions()
        }
    }
}
struct YourSubscriptionsView_Previews: PreviewProvider {
    static var previews: some View {
        YourSubscriptionsView()
    }
}
