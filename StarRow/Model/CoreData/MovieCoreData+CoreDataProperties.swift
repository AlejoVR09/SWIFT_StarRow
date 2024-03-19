//
//  MovieCoreData+CoreDataProperties.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 19/03/24.
//
//

import Foundation
import CoreData


extension MovieCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieCoreData> {
        return NSFetchRequest<MovieCoreData>(entityName: "MovieCoreData")
    }

    @NSManaged public var idMovie: Double
    @NSManaged public var originalTitle: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    //@NSManaged public var user: AppUser?

}

extension MovieCoreData : Identifiable {

}
