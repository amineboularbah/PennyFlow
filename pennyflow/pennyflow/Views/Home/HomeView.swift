//
//  HomeView.swift
//  pennyflow
//
//  Created by Amine on 7/12/2024.
//
import SwiftUI

struct HomeView: View {
    @State private var selectedTab: Int = 0
    var body: some View {
            VStack {
                DashboardView()
                SegmentedControlView(selectedTab: $selectedTab).padding(.vertical, 4)
                // Show the selected page
                TabView(selection: $selectedTab) {
                    YourSubscriptionsView().tag(0)
                    UpcomingBillsView().tag(1)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                Spacer()
            }.ignoresSafeArea()
            .applyDefaultBackground()
        
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
