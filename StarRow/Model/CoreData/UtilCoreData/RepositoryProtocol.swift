//
//  RepositoryProtocol.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 3/04/24.
//

import Foundation
import CoreData

protocol CoreDataRepository {
    func getAll<T>() -> [T]
}
