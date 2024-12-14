//
//  CalendarView.swift
//  pennyflow
//
//  Created by Amine on 7/12/2024.
//
import SwiftUI
import CoreData

struct CalendarView: View {
    @Environment(\.managedObjectContext) var context
    @StateObject private var viewModel: CalendarViewModel
    @State private var navigateToSettings = false
    
    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: CalendarViewModel(context: context))
    }
    
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
                    .padding(.horizontal)
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
        let context = PersistenceController.preview.context
        
        CalendarView(context: context)
            .applyDefaultBackground()
    }
}
