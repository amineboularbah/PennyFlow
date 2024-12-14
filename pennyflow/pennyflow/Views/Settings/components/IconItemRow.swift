//
//  IconItemRow.swift
//  pennyflow
//
//  Created by Amine on 13/12/2024.
//

import SwiftUI

struct IconItemRow: View {
    @State var icon: String = "face_id"
    @State var title: String = "Title"
    @State var value: String = "Value"
    
    var body: some View {
        HStack{
            Image(icon)
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(.gray20)
            
            Text(title)
                .appTextStyle(font: .headline7)
            
            Spacer()
            
            
            Text(value)
                .appTextStyle(font: .headline7, color: .gray30)
             
            
            Image("next")
                .resizable()
                .frame(width: 12, height: 12)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
    }
}

struct IconItemRow_Previews: PreviewProvider {
    static var previews: some View {
        IconItemRow()
            .background(Color.gray60.opacity(0.2)).applyDefaultBackground()
    }
}
