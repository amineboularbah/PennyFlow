//
//  CreditCardModel.swift
//  pennyflow
//
//  Created by Amine on 14/12/2024.
//


import SwiftUI

struct CreditCardModel: Identifiable {
    var id: UUID = UUID()
    var name: String = ""
    var number: String = ""
    var month_year: String = ""
}
