//
//  CoreDataManager.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 24/03/24.
//

import Foundation
import UIKit
import CoreData

// MARK: Class declaration
class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}

    lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - CRUD
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func createEntity<T: NSManagedObject>() -> T {
            let entityName = String(describing: T.self)
            guard let entity = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as? T else {
                fatalError("Core Data entity name doesn't match.")
            }
            return entity
        }
    
    func fetchEntities<T: NSManagedObject>() -> [T] {
        let entityName = String(describing: T.self)
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        do {
            return try context.fetch(fetchRequest)
        } catch let error as NSError {
            fatalError("Failed to fetch entities: \(error), \(error.userInfo)")
        }
    }
    
    func deleteEntity<T: NSManagedObject>(_ entity: T) {
        context.delete(entity)
        saveContext()
    }
}
