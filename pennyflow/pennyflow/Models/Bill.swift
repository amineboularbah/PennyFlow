//
//  Bill.swift
//  pennyflow
//
//  Created by Amine on 20/12/2024.
//
import Foundation

struct Bill: Identifiable {
    let id = UUID() // Generate a unique ID for each bill
    let subscription: Subscription
    let dueDate: Date
}
