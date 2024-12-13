//
//  WeekView.swift
//  pennyflow
//
//  Created by Amine on 13/12/2024.
//

import SwiftUI

// MARK: Week View
struct WeekView: View {
    @ObservedObject var viewModel: CalendarViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(8...14, id: \.self) { day in
                    VStack {
                        Text("\(day)")
                            .font(.headline)
                            .foregroundColor(day == viewModel.selectedDay ? .white : .gray)
                        Text(viewModel.weekday(for: day))
                            .font(.subheadline)
                            .foregroundColor(day == viewModel.selectedDay ? .white : .gray)
                    }
                    .padding()
                    .background(day == viewModel.selectedDay ? Color.accentColor : Color.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        viewModel.selectedDay = day
                    }
                }
            }
        }
    }
}
