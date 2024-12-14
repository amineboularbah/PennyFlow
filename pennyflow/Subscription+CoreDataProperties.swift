//
//  Subscription+CoreDataProperties.swift
//  pennyflow
//
//  Created by Amine on 14/12/2024.
//
//

import Foundation
import CoreData


extension Subscription {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subscription> {
        return NSFetchRequest<Subscription>(entityName: "Subscription")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var icon: String?
    @NSManaged public var desc: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var reminder: String?
    @NSManaged public var user: User?
    @NSManaged public var category: Category?

}

extension Subscription : Identifiable {

}
