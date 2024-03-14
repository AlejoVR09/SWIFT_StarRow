//
//  AppUser+CoreDataProperties.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 13/03/24.
//
//

import Foundation
import CoreData


extension AppUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppUser> {
        return NSFetchRequest<AppUser>(entityName: "AppUser")
    }
    @NSManaged public var email: String?
    @NSManaged public var id: Double
    @NSManaged public var movies: [Int]?
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
}

extension AppUser : Identifiable {

}
