//
//  CustomToggle.swift
//  pennyflow
//
//  Created by Amine on 14/12/2024.
//
import SwiftUI

struct CustomToggle: View {
    @Binding var isOn: Bool
    var activeColor: Color = .blue
    var inactiveColor: Color = .gray

    var body: some View {
        ZStack {
            Capsule()
                .fill(isOn ? activeColor : inactiveColor) // Change track color
                .frame(width: 44, height: 24)
            
            HStack {
                if isOn {
                    Spacer()
                }
                
                Circle()
                    .fill(Color.white) // Knob color
                    .frame(width: 20, height: 20)
                    .padding(2) // Add spacing inside the capsule

                if !isOn {
                    Spacer()
                }
            }
        }.frame(width: 44, height: 24)
        .onTapGesture {
            withAnimation {
                isOn.toggle()
            }
        }
    }
}
