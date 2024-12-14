//
//  CardsView.swift
//  pennyflow
//
//  Created by Amine on 7/12/2024.
//
import SwiftUI

struct CardsView: View {

    @State var cardArr: [CreditCardModel] = [
        CreditCardModel(
            name: "Amine Boularbah", number: "**** **** **** 2789",
            month_year: "08/27"),
        CreditCardModel(
            name: "John Doe", number: "**** **** **** 2788", month_year: "07/27"
        ),
        CreditCardModel(
            name: "Sophia Ramirez", number: "**** **** **** 2754",
            month_year: "01/27"),
        CreditCardModel(
            name: "Ethan Patel", number: "**** **** **** 2720",
            month_year: "03/28"),
        CreditCardModel(
            name: "James Carter", number: "**** **** **** 2730",
            month_year: "08/28"),
    ]

    @Environment(\.managedObjectContext) private var context
    @State private var subArr: [Subscription] = []
    @State var showSettings: Bool = false
    var body: some View {
        NavigationStack {

            ScrollView {

                VStack {

                    CustomAppBar(
                        navigateToSettings: $showSettings, title: "Credit Cards"
                    )

                    CardStack(cardArr) { cObj in

                        ZStack {
                            RoundedRectangle(
                                cornerRadius: 20, style: .continuous
                            )
                            .fill(Color.gray70)
                            .frame(width: 232, height: 350)
                            .shadow(color: .black.opacity(0.2), radius: 4)

                            Image("card_blank")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 232, height: 350)

                            VStack(spacing: 8) {
                                Spacer()
                                    .frame(height: 22)

                                Image("mastercard_logo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50)

                                Text("Virtual Card")
                                    .appTextStyle(font: .headline4)

                                Spacer()
                                    .frame(height: 100)

                                Text(cObj.name)
                                    .appTextStyle(
                                        font: .headline8, color: .gray20)

                                Text(cObj.number)
                                    .appTextStyle(font: .headline6)

                                Text(cObj.month_year)
                                    .appTextStyle(font: .headline7)

                                Spacer()

                            }
                            .foregroundColor(.white)

                        }
                    }
                    .padding(.vertical, 20)

                    VStack {
                        Text("Subscriptions")
                            .appTextStyle(font: .headline6)

                        HStack(spacing: 10) {

                            Spacer()

                            ForEach(subArr) { sObj in
                                Image(sObj.icon ?? "")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                            }

                            Spacer()

                        }
                    }
                    .foregroundColor(.white)
                    .padding(.top, 20)
                    Spacer()
                    OutlinedDashButton(
                        title: "Add new card",
                        onTap: {

                        })

                }
                .padding(.top, .topInsets)

            }.applyDefaultBackground()
                .ignoresSafeArea()
                .navigationDestination(
                    isPresented: $showSettings
                ) {
                    SettingsView()
                }
        }.onAppear {
            loadSubscriptions()
        }

    }
    private func loadSubscriptions() {
            subArr = SubscriptionService.shared.fetchSubscriptions(context: context)
        }
}

struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        CardsView()
            .applyDefaultBackground()
    }
}
