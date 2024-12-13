//
//  HeaderView.swift
//  pennyflow
//
//  Created by Amine on 13/12/2024.
//

import SwiftUI

// MARK: Calendar Header View

struct CalendarHeaderView: View {
    @ObservedObject var viewModel: CalendarViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Subs Schedule")
                .font(.largeTitle).bold()
                .foregroundColor(.white)
            Text("\(viewModel.subscriptions.count) subscriptions for today")
                .font(.subheadline)
                .foregroundColor(.gray)
            HStack {
                Spacer()
                Picker("", selection: $viewModel.selectedMonth) {
                    ForEach(["January", "February", "March"], id: \.self) { month in
                        Text(month).tag(month)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .foregroundColor(.white)
            }
        }
    }
}
