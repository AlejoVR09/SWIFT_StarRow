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
    func saveUser(withEmail: String, withName: String, withPhone: String) {
        let user: AppUser = CoreDataManager.shared.createEntity()
        user.email = withEmail
        user.name = withName
        user.phone = withPhone
        CoreDataManager.shared.saveContext()
    }
    
    func retrieveData() -> [AppUser]{
        CoreDataManager.shared.fetchEntities()
    }
    
    func saveMovieInUser(currentUser: AppUser?, movie: MovieCoreData){
        currentUser?.addToFavorites(movie)
        CoreDataManager.shared.saveContext()
    }
    
    func retrieveUser(email: String) -> AppUser? {
        let users = self.retrieveData()
        return users.first { $0.email == email }
    }
}
