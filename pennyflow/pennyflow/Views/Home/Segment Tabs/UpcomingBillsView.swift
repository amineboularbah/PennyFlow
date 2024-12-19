import SwiftUI

struct UpcomingBillsView: View {
    @EnvironmentObject var viewModel: SubscriptionsViewModel // Access the ViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(viewModel.userSubscriptions) { subscription in
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
        viewModel.fetchUserSubscriptions()
    }
}

struct UpcomingBillsView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingBillsView()
    }
}
