//
//  StatusBannerView.swift
//  pennyflow
//
//  Created by Amine on 9/12/2024.
//

import SwiftUI

struct StatusBannerView: View {
    var message: String

    var body: some View {
        HStack {
            Text(message)
                .appTextStyle(font: .headline7)
            Spacer()
        }.frame(height: 40)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.clear).stroke(
                    Color.gray60,
                    lineWidth: 1
                )
        )
        
        .padding(.horizontal)

    }
}

struct StatusBannerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Preview for Default Configuration
            StatusBannerView(message: "Your budgets are on track")
                .applyDefaultBackground()

        }
    }
}
