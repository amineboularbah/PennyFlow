//
//  ContentView.swift
//  pennyflow
//
//  Created by Amine on 7/12/2024.
//


struct ContentView: View {
    @ObservedObject var subscriptionData = SubscriptionData.shared // Reuse the shared instance

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 20)], spacing: 20) {
                ForEach(subscriptionData.subscriptions) { subscription in
                    VStack {
                        AsyncImage(url: URL(string: subscription.image)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        } placeholder: {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 70, height: 70)
                        }
                        Text(subscription.name)
                            .font(.headline)
                            .lineLimit(1)
                    }
                }
            }
            .padding()
        }
    }
}