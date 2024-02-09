//
//  MovieCoreData+CoreDataProperties.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 6/02/24.
//
//

import Foundation
import CoreData


extension MovieCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieCoreData> {
        return NSFetchRequest<MovieCoreData>(entityName: "MovieCoreData")
    }

    @NSManaged public var posterPath: String?
    @NSManaged public var originalTitle: String?
    @NSManaged public var releaseDate: String?

}

extension MovieCoreData : Identifiable {

}
