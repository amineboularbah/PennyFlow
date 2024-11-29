//
//  PFDropDown.swift
//  pennyflow
//
//  Created by Amine on 29/11/2024.
//

import SwiftUI

struct PFDropdown: View {
    @Binding var selectedOption: String
    var options: [String]
    var placeholder: String = "Select an option"

    @State private var isExpanded = false
    @FocusState private var isFocused: Bool // Focus state for glowing effect

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(placeholder)
                .appTextStyle(font: .bodySmall, color: .gray50)
                .frame(maxWidth: .infinity, alignment: .leading)

            Button(action: {
                isExpanded.toggle()
                isFocused = isExpanded // Toggle focus state based on expansion
            }) {
                HStack {
                    Text(selectedOption.isEmpty ? placeholder : selectedOption)
                        .foregroundColor(selectedOption.isEmpty ? .gray : .white)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                        .foregroundColor(.white)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(isFocused ? Color.secondaryC.opacity(0.8) : Color.gray60, lineWidth: isFocused ? 2 : 1)
                        .background(Color.clear)
                        .shadow(color: isFocused ? Color.secondaryC.opacity(0.5) : Color.clear, radius: isFocused ? 5 : 0)
                )
            }
            .focused($isFocused) // Attach focus binding
            .animation(.easeInOut(duration: 0.2), value: isExpanded)

            if isExpanded {
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(options, id: \.self) { option in
                            Text(option)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .onTapGesture {
                                    selectedOption = option
                                    isExpanded.toggle()
                                    isFocused = false // Remove focus
                                }
                        }
                    }
                }
                .frame(maxHeight: 150) // Limit dropdown height
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gray.opacity(0.1))
                )
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct Dropdown_Previews: PreviewProvider {
    static var previews: some View {
        PFDropdown(
            selectedOption: .constant("USD"),
            options: ["USD", "EUR", "GBP", "MAD"]
        )
        .padding()
        .applyDefaultBackground() // Background for contrast
        .previewLayout(.sizeThatFits)
    }
}
