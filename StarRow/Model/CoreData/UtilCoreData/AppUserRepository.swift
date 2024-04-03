//
//  AooUserCoreData.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 21/03/24.
//

import Foundation
import UIKit

// MARK: Class Declaration
struct AppUserRepository {
    func getAll() -> [AppUser]{
        CoreDataManager.shared.fetchEntities()
    }
    
    func getByEmail(email: String) -> AppUser? {
        let users = self.getAll()
        return users.first { $0.email == email }
    }
    
    func save(withEmail: String, withName: String, withPhone: String) {
        let user: AppUser = CoreDataManager.shared.createEntity()
        user.email = withEmail
        user.name = withName
        user.phone = withPhone
        CoreDataManager.shared.saveContext()
    }
}
