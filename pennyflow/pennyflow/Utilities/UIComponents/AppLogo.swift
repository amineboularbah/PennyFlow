//
//  AppLogo.swift
//  pennyflow
//
//  Created by Amine on 29/11/2024.
//

import SwiftUI

struct AppLogo: View {
    var body: some View {
        Image("app_logo")
            .resizable()
            .scaledToFit()
            .frame(width: .widthPer(per: 55), height: 60)
    }
}

#Preview {
    AppLogo().applyDefaultBackground()
}
