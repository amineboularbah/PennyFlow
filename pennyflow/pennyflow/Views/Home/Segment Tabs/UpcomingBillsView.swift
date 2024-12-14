import SwiftUI

struct UpcomingBillsView: View {
    @Environment(\.managedObjectContext) private var context
    @State private var subscriptions: [Subscription] = []

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(subscriptions) { subscription in
                    SubscriptionRowView(
                        subscription: subscription, showDate: true)
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            fetchSubscriptions()
        }
    }

    // Fetch subscriptions from Core Data
    private func fetchSubscriptions() {
        subscriptions = SubscriptionService.shared.fetchSubscriptions(
            context: context)
    }
}

struct UpcomingBillsView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingBillsView()
    }
}
