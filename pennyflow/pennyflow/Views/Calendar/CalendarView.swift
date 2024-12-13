//
//  CalendarView.swift
//  pennyflow
//
//  Created by Amine on 7/12/2024.
//
import SwiftUI

struct CalendarView: View {
    @StateObject private var viewModel = CalendarViewModel()

    var body: some View {
        VStack {
            VStack(spacing: 20) {
                topBar
                CalendarHeaderView(viewModel: viewModel)

                WeekView(viewModel: viewModel)
            }.padding(.horizontal)
                .padding(.bottom, 40)
                .background(
                    BottomRoundedRectangle(cornerRadius: 40)
                        .fill(Color.gray70)  // Fill with a color
                )
                .ignoresSafeArea()
            VStack {
                CalendarMonthlyBillsView(viewModel: viewModel)
                CalendarSubscriptionsGridView(viewModel: viewModel)
                Spacer()
            }.padding(.horizontal)
        }
        .applyDefaultBackground()
        .navigationTitle("Calendar")
        .navigationBarTitleDisplayMode(.inline)
    }

    // Top Bar with Gear Icon
    private var topBar: some View {
        HStack {
            Spacer()
            Text("      Calendar")
                .appTextStyle(font: .bodyLarge, color: .gray30)
            Spacer()
            Button(action: {
                print("Settings tapped")
            }) {
                Image("settings")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray30)
            }
        }
        .padding(.top, .topInsets)
        
    }
}

// MARK: Preview
struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .applyDefaultBackground()
    }
}
