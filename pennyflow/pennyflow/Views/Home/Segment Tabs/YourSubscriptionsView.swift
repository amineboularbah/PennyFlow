import SwiftUI
import CoreData

struct YourSubscriptionsView: View {
    @EnvironmentObject var subscriptionsViewModel: SubscriptionsViewModel // Access the ViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(subscriptionsViewModel.subscriptions) { subscription in
                    SubscriptionRowView(subscription: subscription, showDate: false)
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            subscriptionsViewModel.fetchSubscriptions() // Fetch subscriptions from the ViewModel
        }
    }
}

struct YourSubscriptionsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SubscriptionsViewModel(context: PersistenceController.preview.context)
        YourSubscriptionsView()
            .environmentObject(viewModel) // Inject the mock ViewModel
    }
}
