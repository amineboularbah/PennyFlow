//
//  SubscriptionInfoView.swift
//  pennyflow
//
//  Created by Amine on 14/12/2024.
//
import SwiftUI

struct SubscriptionInfoView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var subsViewModel: SubscriptionsViewModel
    let subscription: Subscription
    @State private var showAlert = false
    @State private var alertMessage: String = ""

    var body: some View {
    
        ScrollView{
            VStack(spacing: 0) {
                // Header
                VStack {
                    HeaderView(
                        title: "Subscription info",
                        dismissAction: {
                            dismiss()
                        },
                        deleteAction: deleteSubscription
                    )

                    // Subscription Info
                    SubscriptionInfoCard(subscription: subscription)
                    Spacer().frame(height: 30)
                }
                .background(Color.gray70)
                .cornerRadius(radius: 24, corners: [.topLeft, .topRight])
                .padding(.horizontal)
                .padding(.bottom, 0)
                DashDevider()
                    .stroke(style: StrokeStyle(lineWidth: 1.5, dash: [20]))
                    .foregroundColor(Color(hex: "131313"))
                           .frame(height: 2).padding(.horizontal)
                           
                
                VStack {
                    // Details Section
                    DetailsSection(subscription: subscription)
                    Spacer()
                    // Save Button
                    SecondaryButton(title: "Save", action: {
                        dismiss()
                    }, isFilled: true)
                    Spacer()
                   
                }.padding()
                    .background(Color.grayB)
                    .cornerRadius(
                        radius: 24, corners: [.bottomLeft, .bottomRight]
                    )
                    .padding(.horizontal)
                    

            }
        }.alert(isPresented: $showAlert) {
            Alert(
                title: Text("Error"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
            .applyDefaultBackground()
            .navigationBarBackButtonHidden(true)
        

    }
    private func deleteSubscription() {
        do {
            try subsViewModel.deleteSubscription(subscription)
            dismiss()
        } catch {
            // Show an alert if something goes wrong
            alertMessage = "Failed to delete subscription: \(error.localizedDescription)"
            showAlert = true
        }
    }
}

// MARK: - Header View
struct HeaderView: View {
    let title: String
    let dismissAction: () -> Void
    let deleteAction: () -> Void

    var body: some View {
        HStack {
            Button(action: dismissAction) {
                Image("back")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray30)
            }
            Spacer()
            Text(title)
                .appTextStyle(font: .bodyLarge, color: .gray30)
            Spacer()
            Button(action: {
                deleteAction()
            }) {
                Image(systemName: "trash")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray30)
            }
        }
        .padding()
    }
}

// MARK: - Subscription Info Card
struct SubscriptionInfoCard: View {
    let subscription: Subscription

    var body: some View {
        VStack(spacing: 15) {
            Image(subscription.icon ?? "")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .shadow(radius: 31)

            Text(subscription.name ?? "" )
                .appTextStyle(font: .headline3)

          
            Text("$\(String(format: "%.2f", subscription.price))")
                    .appTextStyle(font: .headline5, color: .gray30)
            
            
        }
        .frame(maxWidth: .infinity)
        .padding()

    }
}

// MARK: - Details Section
struct DetailsSection: View {
    let subscription: Subscription

    var body: some View {
        VStack(spacing: 8) {
            DetailRow(title: "Name", value: subscription.name ?? "")
            DetailRow(title: "Description", value: subscription.desc ?? "")
            DetailRow(title: "Category", value: "Entertainment")
            DetailRow(title: "First payment", value: subscription.startDate?.formattedDate() ?? "N/A")
            DetailRow(title: "Reminder", value: "Never")
            DetailRow(title: "Currency", value: "USD ($)")
        }
        .padding()
        .background(Color.gray60.opacity(0.2))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.white.opacity(0.2),  // 15% opacity
                            Color.white.opacity(0),
                            // 10% opacity,,
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1  // Stroke thickness
                )
        )
    }
}

// MARK: - Detail Row
struct DetailRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .appTextStyle(font: .headline7)
            Spacer()
            Text(value)
                .appTextStyle(font: .bodySmall, color: .gray30)
            Image(systemName: "chevron.right")
                
                .foregroundColor(.gray30)
        }
        .padding(.vertical, 12)
    }
}
