//
//  AppUser+CoreDataProperties.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 19/03/24.
//
//

import Foundation
import CoreData


extension AppUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppUser> {
        return NSFetchRequest<AppUser>(entityName: "AppUser")
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var favorites: NSSet?

}

// MARK: Generated accessors for favorites
extension AppUser {

    @objc(addFavoritesObject:)
    @NSManaged public func addToFavorites(_ value: MovieCoreData)

    @objc(removeFavoritesObject:)
    @NSManaged public func removeFromFavorites(_ value: MovieCoreData)

    @objc(addFavorites:)
    @NSManaged public func addToFavorites(_ values: NSSet)

    @objc(removeFavorites:)
    @NSManaged public func removeFromFavorites(_ values: NSSet)

}

extension AppUser : Identifiable {

}
