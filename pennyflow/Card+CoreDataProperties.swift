//
//  Card+CoreDataProperties.swift
//  pennyflow
//
//  Created by Amine on 20/12/2024.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var bankName: String?
    @NSManaged public var cardNumber: String?
    @NSManaged public var cardType: String?
    @NSManaged public var expirationDate: Date?
    @NSManaged public var icon: String?
    @NSManaged public var id: UUID?
    @NSManaged public var user: User?

}

extension Card : Identifiable {

}
