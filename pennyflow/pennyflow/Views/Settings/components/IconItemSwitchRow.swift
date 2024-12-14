//
//  IconItemSwitchRow.swift
//  pennyflow
//
//  Created by Amine on 13/12/2024.
//

import SwiftUI

struct IconItemSwitchRow: View {
    @State var icon: String = "face_id"
    @State var title: String = "Title"
    @Binding var value: Bool
    
    var body: some View {
        HStack{
            Image(icon)
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(.gray30)
            
            Text(title)
                .appTextStyle(font: .headline7)
            
            Spacer()
            
            
            CustomToggle(
                isOn: $value,
                activeColor: .secondaryC,
                        inactiveColor: .gray60
                    )
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
    }
}

struct IconItemSwitchRow_Previews: PreviewProvider {
    @State static var isNO: Bool = false
    static var previews: some View {
        IconItemSwitchRow( value: $isNO)
            .background(Color.gray60.opacity(0.2))
    }
}
