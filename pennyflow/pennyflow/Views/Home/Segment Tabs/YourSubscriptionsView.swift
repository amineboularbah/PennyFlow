import SwiftUI
import CoreData

struct YourSubscriptionsView: View {
    @EnvironmentObject var subscriptionsViewModel: SubscriptionsViewModel // Access the ViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(subscriptionsViewModel.userSubscriptions) { subscription in
                    SubscriptionRowView(subscription: subscription, showDate: false)
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            subscriptionsViewModel.fetchUserSubscriptions() // Fetch subscriptions from the ViewModel
        }
    }
}

struct YourSubscriptionsView_Previews: PreviewProvider {
    static var previews: some View {
        let profileViewModel = ProfileViewModel()

        let viewModel = SubscriptionsViewModel(context: PersistenceController.preview.context, currentUser: profileViewModel.user)
        YourSubscriptionsView()
            .environmentObject(viewModel) // Inject the mock ViewModel
    }
}
