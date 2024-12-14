import SwiftUI

struct UpcomingBillsView: View {
    @State private var subscriptions: [Subscription] = []
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(subscriptions) { subscription in
                    SubscriptionRowView(subscription: subscription, showDate: true)
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            subscriptions = SubscriptionService.fetchSubscriptions()
        }
    }
}

struct UpcomingBillsView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingBillsView()
    }
}
