import SwiftUI

struct UpcomingBillsView: View {
    @EnvironmentObject var viewModel: SubscriptionsViewModel // Access the ViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(viewModel.upcomingBills) { bill in
                    SubscriptionRowView(
                        subscription: bill.subscription, showDate: true, dueDate: bill.dueDate)
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            filterSubscriptions()
        }
    }

    // Fetch subscriptions from Core Data
    private func filterSubscriptions() {
        viewModel.filterSubscriptions()
    }
}

struct UpcomingBillsView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingBillsView()
    }
}
