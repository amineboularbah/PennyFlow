//
//  ContentView.swift
//  pennyflow
//
//  Created by Amine on 7/12/2024.
//

import SwiftUI

struct SubscriptionsGridView: View {
    @EnvironmentObject var platformViewModel: PlatformViewModel
    @Binding var selectedPlatform: Platform? // Track selected subscription ID
    let dismiss: () -> Void
    @State private var showAllSubscriptions = false
    @State private var topSubscriptions: [Platform] = []
    var body: some View {
        VStack {
            Spacer().frame(height: .topInsets)
            HStack {
                Button {
                    // Handle back navigation
                    dismiss()
                } label: {
                    Image("back")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20, height: 20)
                        .foregroundColor(.gray30)
                }
                Text("Top Subscriptions")
                    .appTextStyle(font: .headline5)

                Spacer()

                Button(action: {
                    showAllSubscriptions = true
                }) {
                    Text("See All")
                        .appTextStyle(font: .bodyMedium, color: .gray30)
                }
            }

            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 100), spacing: 20)],
                spacing: 20
            ) {
                ForEach(topSubscriptions, id: \.id) { platform in
                    VStack {
                        SubscriptionImageView(
                            imageName: platform.image ?? "",
                            subscriptionTitle: platform.name ?? "",
                            imageSize: 70
                        )

                        Text(platform.name ?? "")
                            .appTextStyle(font: .bodyLarge)
                            .lineLimit(1)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(
                                selectedPlatform == platform
                                    ? .secondaryC
                                    : Color.clear,
                                lineWidth: 3
                            )
                    )
                    .onTapGesture {
                        selectedPlatform = platform
                        print("Selected subscription: \(platform.name ?? "")")
                    }
                }
            }
            .onAppear {
                if topSubscriptions.isEmpty {
                    topSubscriptions = Array(platformViewModel.platforms.prefix(6))
                }
            }
            .sheet(isPresented: $showAllSubscriptions) {
                AllPlatformsView(
                    selectedPlatform: $selectedPlatform, // Convert Int? to String? and back
                    onSelect: { subscription in
                        updateTopSubscriptions(with: subscription?.id)
                    }
                )
                .environmentObject(platformViewModel)
            }
        }
        .padding()
        .background(
            BottomRoundedRectangle(cornerRadius: 40)
                .fill(Color.gray70)
        )
    }

    private func updateTopSubscriptions(with platform: UUID?) {
        guard let subscription = platform,
              let selectedSubscription = platformViewModel.platforms.first(where: {
                  if let id = $0.id {
                      return  id == platform
                  }
                  return false
              })        else { return }

        if !topSubscriptions.contains(where: { $0.id == selectedSubscription.id }) {
            if topSubscriptions.count < 6 {
                topSubscriptions.append(selectedSubscription)
            } else {
                topSubscriptions[topSubscriptions.count - 1] = selectedSubscription
            }
        }
    }
}
