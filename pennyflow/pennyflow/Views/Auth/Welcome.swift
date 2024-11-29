//
//  Welcome.swift
//  pennyflow
//
//  Created by Amine on 29/11/2024.
//

import SwiftUI

struct Welcome: View {
    var body: some View {
        ZStack{
            Image("welcome_screen")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
            
            VStack{
                Image("app_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: .widthPer(per: 55), height: 100)
                    .padding(.top, .topInsets)
                Spacer()
                Text("Track your expenses, visualize your finances, and achieve your goals with ease.")
                    .font(.customfont(.medium, fontSize: 14))
                    
                
            }
            
        }.ignoresSafeArea()
    }
}
#Preview {
    Welcome()
}
