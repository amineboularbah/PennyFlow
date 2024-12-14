//
//  AppBar.swift
//  pennyflow
//
//  Created by Amine on 14/12/2024.
//

import SwiftUI

struct CustomAppBar: View {
    @Binding var navigateToSettings: Bool
    var title: String = ""
    var body: some View {
        HStack {
            Spacer()
            Text("      \(title)")
                .appTextStyle(font: .bodyLarge, color: .gray30)
            Spacer()
            Button(action: {
                print("Settings tapped")
                navigateToSettings = true
            }) {
                Image("settings")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray30)
            }
        }.padding(.horizontal)

    }
}

#Preview {
    CustomAppBar(navigateToSettings: .constant(false))
}
