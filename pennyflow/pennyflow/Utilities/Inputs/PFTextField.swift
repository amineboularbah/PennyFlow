//
//  PFTextField.swift
//  pennyflow
//
//  Created by Amine on 29/11/2024.
//

import SwiftUI

struct CustomTextField: View {
    @FocusState private var isFocused: Bool
    var placeholder: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(placeholder).appTextStyle(
                font: .bodySmall, color: isFocused ? .secondaryC : .gray50
            )
            .frame(maxWidth: .infinity, alignment: .leading)
            TextField(placeholder, text: $text)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(
                            isFocused
                                ? Color.secondaryC.opacity(0.5)
                                : Color.gray60,
                            lineWidth: isFocused ? 2 : 1
                        )
                        .background(Color.clear)
                        .shadow(
                            color: isFocused
                                ? Color.secondaryC.opacity(0.5) : Color.clear,
                            radius: isFocused ? 5 : 0)
                )
                .foregroundColor(.white)  // Text color
                .focused($isFocused)  // Attach focus binding
        }.frame(maxWidth: .infinity, alignment: .leading)

    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CustomTextField(placeholder: "First Name", text: .constant(""))
            CustomTextField(placeholder: "Email", text: .constant(""))
        }
        .padding()
        .applyDefaultBackground()  // Background for contrast
        .previewLayout(.sizeThatFits)
    }
}
