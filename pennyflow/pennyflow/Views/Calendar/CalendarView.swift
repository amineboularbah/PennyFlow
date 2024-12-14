//
//  CalendarView.swift
//  pennyflow
//
//  Created by Amine on 7/12/2024.
//
import SwiftUI

struct CalendarView: View {
    @StateObject private var viewModel = CalendarViewModel()
    @State private var navigateToSettings = false
    var body: some View {
        NavigationStack {
            VStack {
                VStack(spacing: 20) {
                    CustomAppBar(navigateToSettings: $navigateToSettings, title: "Calendar")
                    CalendarHeaderView(viewModel: viewModel)

                    WeekView(viewModel: viewModel)
                }
                    .padding(.bottom, 40)
                    .padding(.top, .topInsets)
                    .background(
                        BottomRoundedRectangle(cornerRadius: 40)
                            .fill(Color.gray70)  // Fill with a color
                    )
                    .ignoresSafeArea()
                VStack {
                    CalendarMonthlyBillsView(viewModel: viewModel)
                    CalendarSubscriptionsGridView(viewModel: viewModel)
              
                }.padding(.horizontal)
                Spacer()
            }.applyDefaultBackground()
                .navigationDestination(isPresented: $navigateToSettings) {
                    SettingsView()
                }
        }
    }
}

// MARK: Preview
struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .applyDefaultBackground()
    }
}
