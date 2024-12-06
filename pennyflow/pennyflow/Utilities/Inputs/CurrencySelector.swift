//
//  CurrencySelector.swift
//  pennyflow
//
//  Created by Amine on 29/11/2024.
//


import SwiftUI

struct CurrencySelector: View {
    @Binding var selectedCurrency: Currency // Binding for the selected currency

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Currency")
                .appTextStyle(font: .bodySmall, color: .gray50)

            HStack(spacing: 12) {
                ForEach(Currency.allCases, id: \.self) { currency in
                    Button(action: {
                        selectedCurrency = currency
                    }) {
                        Text("\(currency.rawValue)")
                            .font(.headline)
                            .foregroundColor(selectedCurrency == currency ? .secondaryC : .white)
                            .frame(width: 80, height: 40) // Adjust size for consistent layout
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(selectedCurrency == currency ? Color.secondaryC : Color.gray60.opacity(0.5), lineWidth: 2)
                                    .background(Color.clear)
                            )
                    }
                }
            }
        }
        .padding(.vertical, 8)
    }
}
