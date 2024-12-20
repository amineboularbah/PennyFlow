//
//  User+CoreDataProperties.swift
//  pennyflow
//
//  Created by Amine on 20/12/2024.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var appIcon: String?
    @NSManaged public var defaultCurrency: String?
    @NSManaged public var email: String?
    @NSManaged public var font: String?
    @NSManaged public var icloudSyncEnabled: Bool
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var profilePicture: Data?
    @NSManaged public var securityMethod: String?
    @NSManaged public var theme: String?
    @NSManaged public var cards: NSSet?
    @NSManaged public var categories: NSSet?
    @NSManaged public var subscriptions: NSSet?

}

// MARK: Generated accessors for cards
extension User {

    @objc(addCardsObject:)
    @NSManaged public func addToCards(_ value: Card)

    @objc(removeCardsObject:)
    @NSManaged public func removeFromCards(_ value: Card)

    @objc(addCards:)
    @NSManaged public func addToCards(_ values: NSSet)

    @objc(removeCards:)
    @NSManaged public func removeFromCards(_ values: NSSet)

}

// MARK: Generated accessors for categories
extension User {

    @objc(addCategoriesObject:)
    @NSManaged public func addToCategories(_ value: Category)

    @objc(removeCategoriesObject:)
    @NSManaged public func removeFromCategories(_ value: Category)

    @objc(addCategories:)
    @NSManaged public func addToCategories(_ values: NSSet)

    @objc(removeCategories:)
    @NSManaged public func removeFromCategories(_ values: NSSet)

}

// MARK: Generated accessors for subscriptions
extension User {

    @objc(addSubscriptionsObject:)
    @NSManaged public func addToSubscriptions(_ value: Subscription)

    @objc(removeSubscriptionsObject:)
    @NSManaged public func removeFromSubscriptions(_ value: Subscription)

    @objc(addSubscriptions:)
    @NSManaged public func addToSubscriptions(_ values: NSSet)

    @objc(removeSubscriptions:)
    @NSManaged public func removeFromSubscriptions(_ values: NSSet)

}

extension User : Identifiable {

}
