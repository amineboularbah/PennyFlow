//
//  Platform+CoreDataProperties.swift
//  pennyflow
//
//  Created by Amine on 20/12/2024.
//
//

import Foundation
import CoreData


extension Platform {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Platform> {
        return NSFetchRequest<Platform>(entityName: "Platform")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var image: String?
    @NSManaged public var desc: String?
    @NSManaged public var category: Category?
    @NSManaged public var subscriptions: NSSet?

}

// MARK: Generated accessors for subscriptions
extension Platform {

    @objc(addSubscriptionsObject:)
    @NSManaged public func addToSubscriptions(_ value: Subscription)

    @objc(removeSubscriptionsObject:)
    @NSManaged public func removeFromSubscriptions(_ value: Subscription)

    @objc(addSubscriptions:)
    @NSManaged public func addToSubscriptions(_ values: NSSet)

    @objc(removeSubscriptions:)
    @NSManaged public func removeFromSubscriptions(_ values: NSSet)

}

extension Platform : Identifiable {

}
