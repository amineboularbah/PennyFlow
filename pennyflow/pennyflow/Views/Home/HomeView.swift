//
//  HomeView.swift
//  pennyflow
//
//  Created by Amine on 7/12/2024.
//
import SwiftUI

struct HomeView: View {
    var body: some View {
            VStack {
                DashboardView()
                Spacer()
            }.ignoresSafeArea()
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Preview for Default Configuration
            HomeView().applyDefaultBackground()

        }
    }
}
