//
//  Category+CoreDataProperties.swift
//  pennyflow
//
//  Created by Amine on 14/12/2024.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var color: String?
    @NSManaged public var user: User?
    @NSManaged public var subscriptions: NSSet?

}

// MARK: Generated accessors for subscriptions
extension Category {

    @objc(addSubscriptionsObject:)
    @NSManaged public func addToSubscriptions(_ value: Subscription)

    @objc(removeSubscriptionsObject:)
    @NSManaged public func removeFromSubscriptions(_ value: Subscription)

    @objc(addSubscriptions:)
    @NSManaged public func addToSubscriptions(_ values: NSSet)

    @objc(removeSubscriptions:)
    @NSManaged public func removeFromSubscriptions(_ values: NSSet)

}

extension Category : Identifiable {

}
